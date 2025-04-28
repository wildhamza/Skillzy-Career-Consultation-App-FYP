import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class AuthService {
  final box = GetStorage();

  Future<bool> isLoggedIn() async {
    final token = box.read('token');
    if (token == null) {
      return false;
    }

    final baseUrl = dotenv.env['BASE_URL'];
    final url = Uri.parse('$baseUrl/auth/logged-in');

    try {
      final response = await http.get(
        url,
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);

        await box.write('user', responseData['data']['user']);

        return true;
      } else {
        return false;
      }
    } catch (e) {
      return false;
    }
  }

  Future<void> logout() async {
    final token = box.read('token');
    if (token == null) {
      return;
    }

    final baseUrl = dotenv.env['BASE_URL'];
    final url = Uri.parse('$baseUrl/auth/logout');

    try {
      final response = await http.get(
        url,
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        // Logout successful
        await box.remove('token'); // clear token
        await box.remove('user');  // optional: clear user data if you stored it
      } else {
        // Even if logout fails, clear token locally
        await box.remove('token');
        await box.remove('user');
      }
    } catch (e) {
      // In case of error (like server down), clear token anyway
      await box.remove('token');
      await box.remove('user');
    }
  }
}
