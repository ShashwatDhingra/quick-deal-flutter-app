import 'package:flutter/material.dart';
import '../../../../../core/utils/ui_utils/constants/colors.dart';
import 'package:quickdeal/src/core/utils/ui_utils/extensions.dart';
import '../../../../../core/utils/ui_utils/constants/sizes.dart';
import '../../../../../core/utils/ui_utils/constants/text_strings.dart';
import '../../../../customs/custom_elevated_button.dart';
import '../../../../customs/custom_textformfield.dart';

class VerifyEmail extends StatelessWidget {
  const VerifyEmail({
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

    return SingleChildScrollView(
      padding: EdgeInsets.only(
        left: 24,
        right: 24,
        top: 10,
        bottom: bottomInset > 0 ? bottomInset + 20 : 24, // Adjust padding dynamically
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

          // OTP Fields
          if (title != "Set a New Password!")
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: List.generate(4, (index) {
                return textFieldOTP(
                  first: index == 0,
                  last: index == 3,
                  context: context,
                );
              }),
            ),

          if (title != "Set a New Password!") ...[
            const SizedBox(height: Sizes.md),
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
          ],

          const SizedBox(height: Sizes.md),

          // Password Fields
          if (title == "Set a New Password!") ...[
            CustomTextformField(
              cont: TextEditingController(),
              keyboardType: TextInputType.emailAddress,
              decoration: const InputDecoration(
                hintText: Texts.passwordTitle,
                prefixIcon: Icon(Icons.password),
                suffixIcon: Icon(Icons.remove_red_eye),
              ),
            ),
            const SizedBox(height: 24),
            CustomTextformField(
              cont: TextEditingController(),
              keyboardType: TextInputType.emailAddress,
              decoration: const InputDecoration(
                hintText: "Confirm My Password",
                prefixIcon: Icon(Icons.password),
                suffixIcon: Icon(Icons.remove_red_eye),
              ),
            ),
          ],

          const SizedBox(height: 24),
          MElevatedButton(
            text: "Submit",
            onPress: onPress,
          ),
        ],
      ),
    );
  }

  Widget textFieldOTP({
    required bool first,
    required bool last,
    required BuildContext context,
  }) {
    var dark = context.isDarkMode;
    return SizedBox(
      height: 85,
      child: AspectRatio(
        aspectRatio: 1.0,
        child: TextField(
          autofocus: true,
          onChanged: (value) {
            if (value.length == 1 && !last) {
              FocusScope.of(context).nextFocus();
            }
            if (value.isEmpty && !first) {
              FocusScope.of(context).previousFocus();
            }
          },
          showCursor: false,
          readOnly: false,
          textAlign: TextAlign.center,
          style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          keyboardType: TextInputType.number,
          maxLength: 1,
          decoration: InputDecoration(
            counter: const Offstage(),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(width: 1, color: dark ? CColors.darkGrey : CColors.black),
              borderRadius: BorderRadius.circular(12),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: const BorderSide(width: 2, color: CColors.primary),
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        ),
      ),
    );
  }
}
