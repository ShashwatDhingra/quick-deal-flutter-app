import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:quickdeal/src/core/utils/ui_utils/constants/assets.dart';
import 'package:quickdeal/src/core/utils/ui_utils/extensions.dart';
import 'package:quickdeal/src/core/utils/ui_utils/helper.dart';
import 'package:quickdeal/src/presentation/features/onboarding/onboarding_state.dart';

import '../../core/router/routes.dart';
import '../global/user_provider.dart';

class CustomDrawer extends ConsumerWidget {
  const CustomDrawer({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var dark = context.isDarkMode;
    final user = ref.watch(userProvider);
    final onboardingNotifier = ref.read(onboardingStateProvider.notifier);
    return Drawer(
      child: Column(
        children: [
          // Organization Logo
          DrawerHeader(
            //   color: dark ? CColors.black : CColors.lightContainer),
            child: Center(
              child: Image.asset(
                dark
                    ? AssetsConsts.lightLogo
                    : AssetsConsts.darkLogo, // Replace with your logo asset

                width: 150,
                height: 150,
              ),
            ),
          ),

          // User Name
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Text(
              user?.name ?? '', // Replace with dynamic username
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
                _buildListTile(Icons.home, 'Lead', () {
                  context.pushNamed(Routes.leadScreen);
                }),
                _buildListTile(Icons.add, 'Add Property', () {
                  context.pushNamed(Routes.addPropertyScreen);
                }),
                _buildListTile(Icons.business_outlined, 'Propeties', () {
                  context.pushNamed(Routes.propertyListScreen);
                }),
                _buildListTile(Icons.follow_the_signs_outlined, 'Followup', () {
                  context.pushNamed(Routes.followupScreen);
                }),
                _buildListTile(Icons.analytics_outlined, 'CRM DashBoard', () {
                  Navigator.pushNamed(context, Routes.analyticScreen);
                }),
                _buildListTile(Icons.info_outline_rounded, 'About Us', () {
                  context.pushNamed(Routes.aboutUsScreen);
                }),
                _buildListTile(Icons.info, 'Terms & Conditions', () {
                  context.pushNamed(Routes.termsAndConditionScreen);
                }),
                _buildListTile(Icons.info, 'Help', () {
                  context.pushNamed(Routes.helpAndSupportScreen);
                }),
                _buildListTile(Icons.question_answer, 'FAQ', () {
                  context.pushNamed(Routes.faqScreen);
                }),
                _buildListTile(Icons.feedback, 'Feedback', () {
                  context.pushNamed(Routes.feedbackScreen);
                }),
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
                          // Clear User Global Provider
                          ref.read(userProvider.notifier).clearUser();

                          // Jump onto the first page of onboarding screen
                          onboardingNotifier.jumpToFirstPage();

                          // ignore: use_build_context_synchronously
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
