import 'package:basics/components/setting_menu_button.dart';
import 'package:basics/utils/date.dart';
import 'package:basics/utils/theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:basics/services/auth_service.dart';
import 'package:get_storage/get_storage.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final box = GetStorage();
  Map<String, dynamic> userData = {};

  @override
  void initState() {
    super.initState();
    userData = Map<String, dynamic>.from(box.read('user') ?? {});
  }

  void updateUserData(Map<String, dynamic> updatedUser) {
    setState(() {
      userData = updatedUser;
      box.write('user', updatedUser); // Persist the updated user data
    });
  }

  @override
  Widget build(BuildContext context) {
    bool isDarkMode = Theme.of(context).brightness == Brightness.dark;
    String formattedDate = formatDateWithOrdinal(userData["createdAt"]);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Profile", style: TextStyle(fontSize: 30, fontWeight: FontWeight.w600)),
        backgroundColor: Colors.transparent,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 32),
              Row(
                children: [
                  Expanded(
                    flex: 3,
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border(
                          right: BorderSide(
                            color: isDarkMode ? AppTheme.blackPalette[600] ?? Colors.white : AppTheme.whitePalette[600] ?? Colors.black,
                            width: 1,
                          ),
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: AppTheme.primaryColor,
                                width: 3.0,
                              ),
                              borderRadius: BorderRadius.circular(100.0),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(50.0),
                                child: const Icon(
                                  Icons.person,
                                  size: 100.0,
                                  color: Colors.grey,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 4,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 20.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text("Joined"),
                          Text(formattedDate, style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold)),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Text(userData["firstName"] ?? '', style: Theme.of(context).textTheme.displayMedium?.copyWith(fontWeight: FontWeight.w700)),
              const SizedBox(height: 5),
              Text(userData["lastName"] ?? '', style: Theme.of(context).textTheme.displayMedium?.copyWith(fontWeight: FontWeight.w700, color: AppTheme.secondaryColor[700])),
              const SizedBox(height: 40),
              SettingMenuButton(
                title: "Edit Profile",
                has_top_border: true,
                onTap: () {
                  Get.toNamed("edit_profile")!.then((result) {
                    if (result != null && result is Map<String, dynamic>) {
                      updateUserData(result); // Refresh screen with updated user
                    }
                  });
                },
              ),
              SettingMenuButton(
                title: "Change Password",
                onTap: () {
                  Get.toNamed('/change_password');
                },
              ),
              const Spacer(),
              SettingMenuButton(
                title: "Sign out",
                has_top_border: true,
                color: Colors.red,
                onTap: () async {
                  final AuthService authService = AuthService();
                  await authService.logout();
                  Get.offAllNamed('/login');
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}