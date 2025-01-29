import 'package:basics/components/setting_menu_button.dart';
import 'package:basics/utils/theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    bool isDarkMode = Theme.of(context).brightness == Brightness.dark;

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
                                    width: 1
                                )
                            )
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
                                  borderRadius: BorderRadius.circular(50.0), // Round the image
                                  child: const Icon(
                                    Icons.person, // User icon from Material
                                    size: 100.0,  // Adjust size to match the previous image dimensions
                                    color: Colors.grey, // Change color as needed
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      )
                  ),
                  Expanded(
                      flex: 4,
                      child: Padding(
                        padding: const EdgeInsets.only(
                            left: 20.0
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text("Joined"),
                            Text("20th August, 2024", style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold))
                          ],
                        ),
                      )
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Text("Ghayas", style: Theme.of(context).textTheme.displayMedium?.copyWith(fontWeight: FontWeight.w700)),
              const SizedBox(height: 5),
              Text("Ud Din", style: Theme.of(context).textTheme.displayMedium?.copyWith(fontWeight: FontWeight.w700, color: AppTheme.secondaryColor[700])),
              const SizedBox(height: 40),
              SettingMenuButton(title: "Edit Profile", has_top_border: true, onTap: () {
                Get.toNamed('/edit_profile');
              }),
              SettingMenuButton(title: "Change Password", onTap: () {
                Get.toNamed('/change_password');
              }),
              const Spacer(),
              SettingMenuButton(title: "Sign out", has_top_border: true, color: Colors.red, onTap: () {
                Get.offNamed('/login');
              })
            ],
          ),
        ),
      )
    );
  }
}