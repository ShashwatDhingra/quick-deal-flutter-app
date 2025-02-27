import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:quickdeal/src/core/utils/ui_utils/extensions.dart';
import 'package:quickdeal/src/presentation/features/auth/states/signup_state.dart';
import 'package:quickdeal/src/presentation/features/auth/ui/screens/signin_screen.dart';
import 'package:quickdeal/src/presentation/features/auth/ui/widget/pin_sheet.dart';

import '../../../../../core/router/routes.dart';
import '../../../../../core/utils/ui_utils/constants/assets.dart';
import '../../../../../core/utils/ui_utils/constants/colors.dart';
import '../../../../../core/utils/ui_utils/constants/sizes.dart';
import '../../../../../core/utils/ui_utils/constants/text_strings.dart';
import '../../../../../data/models/user_model.dart';
import '../../../../customs/custom_checkbox.dart';

import '../../../../customs/custom_elevated_button.dart';
import '../../../../customs/custom_textformfield.dart';
import '../../../../global/user_provider.dart';
import '../widget/terms_condition_screen.dart';

class SignupScreen extends ConsumerStatefulWidget {
  SignupScreen({super.key});

  @override
  ConsumerState<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends ConsumerState<SignupScreen>
    with TickerProviderStateMixin {
  final ValueNotifier<bool> checkboxState = ValueNotifier<bool>(true);

  @override
  Widget build(BuildContext context) {
    final signupState = ref.watch(signupStateProvider);
    final signupNotifier = ref.read(signupStateProvider.notifier);
    var dark = context.isDarkMode;
    return Scaffold(
        body: SafeArea(
      child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32),
          child: Center(
            child: SingleChildScrollView(
              child: IntrinsicHeight(
                child: Form(
                  key: signupNotifier.signupFormKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        dark ? AssetsConsts.darkLogo : AssetsConsts.lightLogo,
                        height: 50,
                      ),
                      const Text(Texts.signupTitle),
                      const SizedBox(
                        height: Sizes.lg,
                      ),

                      // Email TextField
                      Form(
                        key: signupNotifier.emailFormKey,
                        child: CustomTextformField(
                          isEnabled: !signupState.isEmailConfirmed,
                          cont: signupState.emailController,
                          keyboardType: TextInputType.emailAddress,
                          decoration: InputDecoration(
                              hintText: Texts.emailTitle,
                              prefixIcon: const Icon(Icons.email_outlined),
                              suffixIcon: Icon(
                                signupState.isEmailConfirmed
                                    ? Icons.check_circle_rounded
                                    : Icons.check_circle_outline_outlined,
                                color: signupState.isEmailConfirmed
                                    ? Colors.green
                                    : null,
                              )),
                        ),
                      ),
                      24.hBox,

                      // Name TextField
                      CustomTextformField(
                        cont: signupState.nameController,
                        isEnabled: signupState.isEmailConfirmed,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please fill the name';
                          }
                          if (value.length < 3) {
                            return 'Name must be more than 2 words';
                          }
                          return null;
                        },
                        decoration: const InputDecoration(
                          hintText: Texts.name,
                          prefixIcon: Icon(
                            Icons.person,
                          ),
                        ),
                      ),
                      24.hBox,
                      CustomTextformField(
                        cont: signupState.passwordController,
                        isEnabled: signupState.isEmailConfirmed,
                        keyboardType: TextInputType.visiblePassword,
                        validator: (value) {
                          final err = passwordValidator(value);
                          if (err == null &&
                              (signupState.passwordController.text !=
                                  signupState.cnfrmPassController.text)) {
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
                        cont: signupState.cnfrmPassController,
                        isEnabled: signupState.isEmailConfirmed,
                        keyboardType: TextInputType.visiblePassword,
                        validator: (value) {
                          final err = passwordValidator(value);
                          if (err == null &&
                              (signupState.passwordController.text !=
                                  signupState.cnfrmPassController.text)) {
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
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodySmall!
                                          .copyWith(
                                              color: dark
                                                  ? CColors.light
                                                  : Colors.black),
                                    ),
                                    TextSpan(
                                      text: "terms & conditions",
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodySmall!
                                          .copyWith(color: Colors.blue),
                                    ),
                                    TextSpan(
                                      text: " and ",
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodySmall!
                                          .copyWith(
                                              color: dark
                                                  ? CColors.light
                                                  : Colors.black),
                                    ),
                                    TextSpan(
                                      text: "privacy policy",
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodySmall!
                                          .copyWith(color: Colors.blue),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: Sizes.lg,
                      ),
                      if (!signupState.isEmailConfirmed)
                        CustomElevatedButton(
                          text: 'Verify Email',
                          onPress: () async {
                            final response = await signupNotifier.confirmMail();

                            if (response) {
                              showModalBottomSheet(
                                useSafeArea: true,
                                context: context,
                                builder: (context) {
                                  return PinSheet(isSignup: true);
                                },
                              );
                            }
                          },
                        ),
                      if (signupState.isEmailConfirmed)
                        CustomElevatedButton(
                          text: Texts.signUp,
                          onPress: () async {
                            final response = await signupNotifier.signup(ref);

                            if (response) {
                              context.pushNamedAndRemoveUntil(
                                  Routes.dashboardScreen,
                                  predicate: (route) => false);
                            }
                            // showModalBottomSheet(
                            //   useSafeArea: true,
                            //   context: context,
                            //   builder: (context) {
                            //     return ForgetPasswordScreen();
                            //   },
                            // );
                          },
                        ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text("${Texts.alreadyHaveAccount} ? "),
                          TextButton(
                              onPressed: () {
                                context.pop();

                                final bottomSheetController =
                                    AnimationController(
                                  vsync: this,
                                  duration: const Duration(milliseconds: 700),
                                );

                                showModalBottomSheet(
                                  isScrollControlled: true,
                                  context: context,
                                  transitionAnimationController:
                                      bottomSheetController,
                                  builder: (context) {
                                    return FractionallySizedBox(
                                      heightFactor: 0.8,
                                      child: AnimatedBuilder(
                                        animation: bottomSheetController,
                                        builder: (context, child) {
                                          return child!;
                                        },
                                        child: SigninScreen(),
                                      ),
                                    );
                                  },
                                );
                              },
                              child: const Text("${Texts.signIn} here"))
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          )),
    ));
  }
}
