import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:quickdeal/src/core/router/routes.dart';
import 'package:quickdeal/src/presentation/features/auth/states/signin_state.dart';
import 'package:quickdeal/src/presentation/features/auth/ui/widget/success.dart';
import '../../../../../core/utils/ui_utils/constants/colors.dart';
import 'package:quickdeal/src/core/utils/ui_utils/extensions.dart';
import '../../../../../core/utils/ui_utils/constants/sizes.dart';
import '../../../../../core/utils/ui_utils/constants/text_strings.dart';
import '../../../../customs/custom_elevated_button.dart';
import '../../../../customs/custom_textformfield.dart';

class ResetPassword extends ConsumerWidget {
  const ResetPassword({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final signinState = ref.watch(signinStateProvider);
    final signinNotifier = ref.read(signinStateProvider.notifier);
    var dark = context.isDarkMode;
    final bottomInset = MediaQuery.of(context).viewInsets.bottom;

    return SingleChildScrollView(
      padding: EdgeInsets.only(
        left: 24,
        right: 24,
        top: 10,
        bottom: bottomInset > 0
            ? bottomInset + 20
            : 24, // Adjust padding dynamically
      ),
      child: Form(
        key: signinNotifier.resetPasswordFormKey,
        child: Column(
          children: [
            Text(
              "Set a New Password!",
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            Sizes.lg.ph,
            const Text(
              "Please set a new password.",
            ),
            const SizedBox(height: Sizes.md),
            // Password Fields
            CustomTextformField(
              cont: signinState.newPassCtrl,
              validator: (value) {
                final err = passwordValidator(value);
                if (err == null &&
                    (signinState.newPassCtrl.text !=
                        signinState.cnfrmNewPassCtrl.text)) {
                  return "Password doesn't match";
                }
                return err;
              },
              decoration: const InputDecoration(
                hintText: Texts.passwordTitle,
                prefixIcon: Icon(Icons.password),
                suffixIcon: Icon(Icons.remove_red_eye),
              ),
            ),
            const SizedBox(height: 24),
            CustomTextformField(
              cont: signinState.cnfrmNewPassCtrl,
              validator: (value) {
                final err = passwordValidator(value);
                if (err == null &&
                    (signinState.newPassCtrl.text !=
                        signinState.cnfrmNewPassCtrl.text)) {
                  return "Password doesn't match";
                }
                return err;
              },
              decoration: const InputDecoration(
                hintText: "Confirm My Password",
                prefixIcon: Icon(Icons.password),
                suffixIcon: Icon(Icons.remove_red_eye),
              ),
            ),
            const SizedBox(height: 24),
            MElevatedButton(
              text: "Submit",
              onPress: () async {
                final response = await signinNotifier.resetPassword();

                if (response) {
                  context.pop(context);

                  showModalBottomSheet(
                    context: context,
                    isScrollControlled: true,
                    builder: (context) {
                      return SuccessScreen(
                        title: "Password Has Been created",
                        subtitle:
                            "To log in to your account, click the Sign in button and enter your email along with your new password.",
                        onPress: () {
                          context.pushNamed(Routes.signinScreen);
                        },
                      );
                    },
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
