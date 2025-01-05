import 'package:basics/components/setting_menu_button.dart';
import 'package:basics/utils/theme.dart';
import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    bool isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            width: double.infinity,
            height: MediaQuery.of(context).size.height,
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Center(
                  child: Text(
                    "Profile",
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
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
                                    child: const Image(
                                      image: AssetImage('assets/img/profile.png'),
                                      width: 100.0, // Set image width
                                      height: 100.0, // Set image height
                                      fit: BoxFit.cover, // Adjust image scaling
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
                              Text("20th August, 2024", style: Theme.of(context).textTheme.titleMedium)
                            ],
                          ),
                        )
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Text("Syeda", style: Theme.of(context).textTheme.displayMedium?.copyWith(fontWeight: FontWeight.w700)),
                const SizedBox(height: 5),
                Text("Arooba", style: Theme.of(context).textTheme.displayMedium?.copyWith(fontWeight: FontWeight.w700, color: AppTheme.secondaryColor[700])),
                const SizedBox(height: 40),
                SettingMenuButton(title: "Edit Profile", has_top_border: true, onTap: () {}),
                SettingMenuButton(title: "Change Password", onTap: () {}),
                SettingMenuButton(title: "Sign out", color: Colors.red, onTap: () {})
              ],
            ),
          ),
        ),
      )
    );
  }
}