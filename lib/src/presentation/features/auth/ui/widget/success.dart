import 'package:flutter/material.dart';
import 'package:quickdeal/src/core/utils/ui_utils/extensions.dart';
import '../../../../../core/utils/ui_utils/constants/colors.dart';
import '../../../../../core/utils/ui_utils/constants/sizes.dart';
import '../../../../customs/custom_elevated_button.dart';
import '../../../../customs/custom_outline_button.dart';

class SuccessScreen extends StatelessWidget {
  const SuccessScreen({
    super.key,
    required this.onPress,
    required this.title,
    required this.subtitle,
  });

  final void Function() onPress;
  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    var dark = context.isDarkMode;
    final bottomInset = MediaQuery.of(context).viewInsets.bottom;

    return LayoutBuilder(
      builder: (context, constraints) {
        return SingleChildScrollView(
          padding: EdgeInsets.only(
            left: 24,
            right: 24,
            top: 10,
            bottom: bottomInset > 0 ? bottomInset + 20 : 24, // Dynamic padding
          ),
          child: Column(
            children: [
              Text(
                title,
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              const SizedBox(height: Sizes.lg),
              Text(
                subtitle,
                textAlign: TextAlign.justify,
              ),
              const SizedBox(height: Sizes.md),
              if (title != "Password Has Been created")
                RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: "Haven't received the verification code? ",
                        style: TextStyle(color: dark ? CColors.light : Colors.black),
                      ),
                      const TextSpan(
                        text: " Resend it.",
                        style: TextStyle(color: Colors.blue),
                      ),
                    ],
                  ),
                ),
              const SizedBox(height: Sizes.md),
              MElevatedButton(
                text: "Submit",
                onPress: onPress,
              ),
              if (title != "Password Has Been created") ...[
                const SizedBox(height: Sizes.md),
                MOutlinedButton(
                  text: "Explore The App First",
                  onPress: () {
                    context.pop();
                  },
                ),
              ],
            ],
          ),
        );
      },
    );
  }
}
