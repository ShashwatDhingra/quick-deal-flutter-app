import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:quickdeal/src/core/utils/ui_utils/constants/assets.dart';
import 'package:quickdeal/src/core/utils/ui_utils/extensions.dart';
import 'package:quickdeal/src/core/utils/ui_utils/helper.dart';

import '../../core/router/routes.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    var dark = context.isDarkMode;
    return Drawer(
      child: Column(
        children: [
          // Organization Logo
          DrawerHeader(
            //   color: dark ? CColors.black : CColors.lightContainer),
            child: Center(
              child: Image.asset(
                dark
                    ? AssetsConsts.hrNextDarkLogo
                    : AssetsConsts
                        .hrNextLightLogo, // Replace with your logo asset

                width: 150,
                height: 150,
              ),
            ),
          ),

          // User Name
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Text(
              'John Doe', // Replace with dynamic username
              style: TextStyle(
                fontSize: 18.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),

          SizedBox(height: 20.h), // Space

          // List of Features with Icons
          Expanded(
            child: ListView(
              padding: EdgeInsets.zero,
              children: [
                _buildListTile(Icons.home, 'Lead', () {}),
                _buildListTile(Icons.add, 'Add Property', () {}),
                _buildListTile(Icons.business_outlined, 'Propeties', () {}),
                _buildListTile(
                    Icons.follow_the_signs_outlined, 'Followup', () {}),
                _buildListTile(Icons.analytics_outlined, 'CRM DashBoard', () {
                  Navigator.pushNamed(context, Routes.analyticScreen);
                }),
                _buildListTile(Icons.info_outline_rounded, 'About Us', () {}),
                _buildListTile(Icons.info, 'Terms & Conditions', () {}),
                _buildListTile(Icons.info, 'Help', () {}),
                _buildListTile(Icons.question_answer, 'FAQ', () {}),
                _buildListTile(Icons.feedback, 'Feedback', () {}),
                _buildListTile(Icons.bug_report, 'Report a Bug', () {}),
              ],
            ),
          ),

          // Logout Button
          const Divider(),
          ListTile(
            leading: const Icon(
              Icons.logout,
              color: Colors.red,
            ),
            title: const Text(
              'Logout',
              style: TextStyle(
                color: Colors.red,
                fontWeight: FontWeight.bold,
              ),
            ),
            onTap: () {
              showCupertinoDialog(
                context: context,
                builder: (context) => CupertinoAlertDialog(
                  title: const Text('Log-out'),
                  content:
                      const Text('Are you sure you want to log-out the app?'),
                  actions: [
                    CupertinoDialogAction(
                      onPressed: () => Navigator.of(context).pop(false),
                      child: const Text('No'),
                    ),
                    CupertinoDialogAction(
                      isDestructiveAction: true,
                      onPressed: () async {
                        if (await AuthPrefHelper.clearToken()) {
                          context.pushNamedAndRemoveUntil(
                              Routes.onboardingScreen,
                              predicate: (route) => false);
                        } else {
                          "Some Error Occured".showErrorToast();
                        }
                      },
                      child: const Text('Yes'),
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  // Helper function to create ListTile with icon and text
  Widget _buildListTile(IconData icon, String title, VoidCallback onTap) {
    return ListTile(
      leading: Icon(icon),
      title: Text(title),
      onTap: onTap,
    );
  }
}
