import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:quickdeal/src/presentation/features/auth/states/signin_state.dart';
import 'package:quickdeal/src/presentation/features/auth/states/signup_state.dart';
import 'package:quickdeal/src/presentation/features/auth/ui/widget/reset_password.dart';
import '../../../../../core/utils/ui_utils/constants/colors.dart';
import 'package:quickdeal/src/core/utils/ui_utils/extensions.dart';
import '../../../../../core/utils/ui_utils/constants/sizes.dart';
import '../../../../../core/utils/ui_utils/constants/text_strings.dart';
import '../../../../customs/custom_elevated_button.dart';
import '../../../../customs/custom_textformfield.dart';

class PinSheet extends ConsumerWidget {
  PinSheet({super.key, required this.isSignup});

  bool isSignup;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final signinState = ref.watch(signinStateProvider);
    final signinNotifier = ref.read(signinStateProvider.notifier);
    final signupState = ref.watch(signupStateProvider);
    final signupNotifier = ref.read(signupStateProvider.notifier);
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
      child: Column(
        children: [
          Text(
            "Confirm Pin",
            style: Theme.of(context).textTheme.headlineMedium,
          ),
          Sizes.lg.hBox,
          Text(
            isSignup
                ? "A code has been sent. Check your email to continue the signup process."
                : "A reset code has been sent. Check your email to continue the password reset process.",
          ),
          const SizedBox(height: Sizes.md),
          Form(
            key: isSignup
                ? signupNotifier.pinFormKey
                : signinNotifier.pinFormKey,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: List.generate(4, (index) {
                return textFieldOTP(
                  first: index == 0,
                  last: index == 3,
                  controller: isSignup
                      ? signupState.pinControllers[index]
                      : signinState.pinControllers[index],
                  context: context,
                );
              }),
            ),
          ),
          const SizedBox(height: Sizes.md),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Haven't received the verification code? ",
                style: TextStyle(color: dark ? CColors.light : Colors.black),
              ),
              GestureDetector(
                onTap: () {
                  isSignup
                      ? signupNotifier.confirmMail()
                      : signinNotifier.sendVerificationCode();
                },
                child: const Text(
                  " Resend it.",
                  style: TextStyle(color: Colors.blue),
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          CustomElevatedButton(
            text: "Submit",
            onPress: () async {
              final response = isSignup
                  ? await signupNotifier.verifyPin()
                  : await signinNotifier.verifyPin();

              if (response) {
                context.pop();

                if (isSignup) return;

                showModalBottomSheet(
                  context: context,
                  isScrollControlled: true,
                  builder: (context) {
                    return const ResetPassword();
                  },
                );
              }
            },
          ),
        ],
      ),
    );
  }

  Widget textFieldOTP({
    required bool first,
    required bool last,
    required TextEditingController controller,
    required BuildContext context,
    Color borderColor = CColors.primary, // Customizable border color
  }) {
    var dark = context.isDarkMode;

    return SizedBox(
      height: 85,
      child: AspectRatio(
        aspectRatio: 1.0,
        child: TextFormField(
          controller: controller,
          maxLength: 1,
          autofocus: first, // Autofocus only the first field
          keyboardType: TextInputType.number,
          textAlign: TextAlign.center,
          style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          validator: (value) => (value == null || value.isEmpty) ? '' : null,
          inputFormatters: [
            FilteringTextInputFormatter.digitsOnly
          ], // Restrict non-numeric input
          decoration: InputDecoration(
            counterText: '', // Hide counter text
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.0),
              borderSide: BorderSide(color: borderColor, width: 2.0),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.0),
              borderSide: const BorderSide(color: Colors.red, width: 1.5),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.0),
              borderSide: const BorderSide(color: Colors.red, width: 2.0),
            ),
          ),
          onChanged: (value) {
            if (value.isNotEmpty) {
              if (!last) FocusScope.of(context).nextFocus();
            } else if (!first) {
              FocusScope.of(context).previousFocus();
            }
          },
        ),
      ),
    );
  }
}
