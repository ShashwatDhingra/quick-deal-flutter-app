import 'package:flutter/material.dart';
import 'package:quickdeal/src/core/utils/ui_utils/extensions.dart';


import '../../../../../core/utils/ui_utils/constants/assets.dart';
import '../../../../../core/utils/ui_utils/constants/colors.dart';
import '../../../../../core/utils/ui_utils/constants/sizes.dart';
import '../../../../../core/utils/ui_utils/constants/text_strings.dart';
import '../../../../customs/custom_checkbox.dart';

import '../../../../customs/custom_elevated_button.dart';
import '../../../../customs/custom_textformfield.dart';
import '../widget/success.dart';
import '../widget/terms_condition_screen.dart';
import '../widget/verify_email.dart';

class SignupScreen extends StatelessWidget {
  SignupScreen({super.key});

  final ValueNotifier<bool> checkboxState = ValueNotifier<bool>(true);

  @override
  Widget build(BuildContext context) {
    var dark = context.isDarkMode;
    return Scaffold(
        body: SafeArea(
      child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32),
          child: Center(
            child: SingleChildScrollView(
              child: IntrinsicHeight(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      dark
                          ? AssetsConsts.hrNextDarkLogo
                          : AssetsConsts.hrNextLightLogo,
                      height: 50,
                    ),
                    const Text(Texts.signupTitle),
                    const SizedBox(
                      height: Sizes.lg,
                    ),
                    CustomTextformField(
                      cont: TextEditingController(),
                      keyboardType: TextInputType.emailAddress,
                      decoration: const InputDecoration(
                        hintText: Texts.emailTitle,
                        prefixIcon: Icon(Icons.email_outlined),
                      ),
                    ),
                    const SizedBox(height: 24),
                    CustomTextformField(
                      cont: TextEditingController(),
                      keyboardType: TextInputType.phone,
                      decoration: const InputDecoration(
                        hintText: "Phone",
                        prefixIcon: Icon(Icons.phone),
                      ),
                    ),
                    const SizedBox(height: 24),
                    CustomTextformField(
                      cont: TextEditingController(),
                      keyboardType: TextInputType.emailAddress,
                      decoration: const InputDecoration(
                        hintText: "Enter Company ID",
                        prefixIcon: Icon(Icons.mail_outline),
                      ),
                    ),
                    const SizedBox(height: 24),
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
                    const SizedBox(height: 32),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            ValueListenableBuilder<bool>(
                              valueListenable: checkboxState,
                              builder: (context, value, child) {
                                return CustomCheckbox(
                                  isChecked: value,
                                  onChanged: (newValue) {
                                    checkboxState.value = newValue!;

                                    showModalBottomSheet(
                                      context: context,
                                      builder: (context) {
                                        return const TermsConditionScreen();
                                      },
                                    );
                                  },
                                );
                              },
                            ),
                            const SizedBox(
                              width: Sizes.sm,
                            ),
                            RichText(
                              text: TextSpan(
                                children: [
                                  TextSpan(
                                    text: "I agree with ",
                                    style: TextStyle(
                                        color: dark
                                            ? CColors.light
                                            : Colors.black),
                                  ),
                                  const TextSpan(
                                    text: "terms & conditions",
                                    style: TextStyle(
                                      color: Colors.blue,
                                    ),
                                  ),
                                  TextSpan(
                                    text: " and ",
                                    style:
                                        Theme.of(context).textTheme.titleSmall,
                                  ),
                                  const TextSpan(
                                    text: "privacy policy",
                                    style: TextStyle(
                                      color: Colors.blue,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: Sizes.lg,
                    ),
                    MElevatedButton(
                      text: Texts.signUp,
                      onPress: () {
                        showModalBottomSheet(
                          useSafeArea: true,
                          context: context,
                          builder: (context) {
                            return VerifyEmail(
                              title: "Email verification Sent!",
                              subtitle:
                                  "A verification code will be sent to the email Hello@work.com for your account verification process.",
                              onPress: () {
                                context.pop();
                                showModalBottomSheet(
                                  useSafeArea: true,
                                  context: context,
                                  builder: (context) {
                                    return SuccessScreen(
                                      subtitle:
                                          "A verification code will be sent to the email Hello@work.com for your account verification process.",
                                      title: "Email verification Sent!",
                                      onPress: () {
                                        context.pop();
                                      },
                                    );
                                  },
                                );
                              },
                            );
                          },
                        );
                      },
                    ),
                    // const SizedBox(
                    //   height: Sizes.lg,
                    // ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text("${Texts.alreadyHaveAccount} ? "),
                        TextButton(
                            onPressed: () {
                              context.pop();
                            },
                            child: const Text("${Texts.signIn} here"))
                      ],
                    ),
                  ],
                ),
              ),
            ),
          )),
    ));
  }
}
