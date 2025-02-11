import 'package:flutter/material.dart';

import '../../../../../core/utils/ui_utils/constants/sizes.dart';
import '../../../../../core/utils/ui_utils/constants/text_strings.dart';
import '../../../../customs/custom_elevated_button.dart';
import '../../../../customs/custom_textformfield.dart';

class ForgetPasswordScreen extends StatelessWidget {
  const ForgetPasswordScreen({super.key, required this.onPress});

  final void Function() onPress;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final bottomInset = MediaQuery.of(context).viewInsets.bottom;

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
                Texts.forgetPassword,
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              const SizedBox(height: Sizes.lg),
              const Text(
                "A verification code will be sent to your email to reset your password.",
                textAlign: TextAlign.justify,
              ),
              const SizedBox(height: Sizes.md),
              CustomTextformField(
                cont: TextEditingController(),
                keyboardType: TextInputType.emailAddress,
                decoration: const InputDecoration(
                  hintText: Texts.emailTitle,
                  prefixIcon: Icon(Icons.email_outlined),
                ),
              ),
              const SizedBox(height: Sizes.lg),
              MElevatedButton(
                text: "Send verification code",
                onPress: onPress,
              ),
            ],
          ),
        );
      },
    );
  }
}
