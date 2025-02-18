import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:quickdeal/src/core/utils/ui_utils/extensions.dart';
import 'package:quickdeal/src/presentation/features/auth/states/signin_state.dart';
import 'package:quickdeal/src/presentation/features/auth/ui/widget/pin_sheet.dart';
import 'package:quickdeal/src/presentation/features/auth/ui/widget/reset_password.dart';

import '../../../../../core/utils/ui_utils/constants/sizes.dart';
import '../../../../../core/utils/ui_utils/constants/text_strings.dart';
import '../../../../customs/custom_elevated_button.dart';
import '../../../../customs/custom_textformfield.dart';

class ForgetPasswordScreen extends ConsumerWidget {
  const ForgetPasswordScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final signinState = ref.watch(signinStateProvider);
    final signinNotifier = ref.read(signinStateProvider.notifier);
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
          child: Form(
            key: signinNotifier.fpFormKey,
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
                  cont: signinState.fpEmailController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: const InputDecoration(
                    hintText: Texts.emailTitle,
                    prefixIcon: Icon(Icons.email_outlined),
                  ),
                ),
                const SizedBox(height: Sizes.lg),
                MElevatedButton(
                  text: "Send verification code",
                  onPress: () async {
                    final response =
                        await signinNotifier.sendVerificationCode();
                    if (response) {
                      context.pop();
                      showModalBottomSheet(
                        isScrollControlled: true,
                        context: context,
                        builder: (context) {
                          return PinSheet(isSignup: false);
                        },
                      );
                    }
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
