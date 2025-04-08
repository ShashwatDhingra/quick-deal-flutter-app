import 'package:quickdeal/src/presentation/customs/custom_elevated_button.dart';
import 'package:quickdeal/src/presentation/customs/custom_textformfield.dart';
import 'package:quickdeal/src/presentation/features/dashboard/subscreens/profile/profile.dart';

import 'state/help_state.dart';

class HelpSupportScreen extends ConsumerWidget {
  const HelpSupportScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final helpState = ref.watch(helpSupportStateProvider);
    final helpNotifier = ref.read(helpSupportStateProvider.notifier);
    var isDark = context.isDarkMode;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Help & Support"),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Contact Information Section
            Text(
              "Contact Us",
              style: TextStyle(
                fontSize: 22.sp,
                fontWeight: FontWeight.bold,
                color: isDark ? CColors.textWhite : CColors.primary,
              ),
            ),
                        16.hBox,
            _buildContactInfo(
              isDark: isDark,
              icon: Icons.phone,
              title: "Phone",
              value: "+1 (123) 456-7890",
            ),
                       12.hBox,
            _buildContactInfo(
              isDark: isDark,
              icon: Icons.email,
              title: "Email",
              value: "support@quickdeal.com",
            ),
            12.hBox,
            _buildContactInfo(
              isDark: isDark,
              icon: Icons.location_on,
              title: "Address",
              value: "123 Main St, City, Country",
            ),
            24.hBox,

            // Help Request Form
            Text(
              "Request Help",
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: isDark ? CColors.textWhite : CColors.primary,
              ),
            ),
            16.hBox,
            Form(
              key: helpNotifier.helpFormKey,
              child: Column(
                children: [
                  CustomTextformField(
                    isEnabled: false,
                    cont: helpState.nameController,
                    labelText: "Your Name *",
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Please enter your name";
                      }
                      return null;
                    },
                  ),
                 16.hBox,
                  CustomTextformField(
                    isEnabled: false,
                    cont: helpState.emailController,
                    labelText: "Your Email *",
                    keyboardType: TextInputType.emailAddress,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Please enter your email";
                      }
                      if (!value.contains("@")) {
                        return "Please enter a valid email";
                      }
                      return null;
                    },
                  ),
                  16.hBox,
                  CustomTextformField(
                    cont: helpState.subjectController,
                    labelText: "Subject *",
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Please enter a subject";
                      }
                      return null;
                    },
                  ),
                   16.hBox,
                  CustomTextformField(
                    cont: helpState.messageController,
                    labelText: "Message *",
                    maxLines: 5,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Please enter your message";
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 24),
                  CustomElevatedButton(
                    text: Texts.submit,
                    onPress: () {
                      helpNotifier.submitHelpRequest(ref);
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildContactInfo(
      {required IconData icon,
      required String title,
      required String value,
      required bool isDark}) {
    return Row(
      children: [
        Icon(icon,
            color: isDark ? CColors.textWhite : CColors.primary, size: 24),
        const SizedBox(width: 12),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: isDark ? CColors.textWhite : Colors.black87,
              ),
            ),
            Text(
              value,
              style: TextStyle(
                fontSize: 14.sp,
                color: isDark ? CColors.textWhite : Colors.black54,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
