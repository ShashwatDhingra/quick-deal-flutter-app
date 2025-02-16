import 'package:quickdeal/src/core/utils/ui_utils/extensions.dart';
import 'package:quickdeal/src/presentation/features/auth/states/signin_state.dart';
import 'package:quickdeal/src/presentation/features/auth/ui/widget/success.dart';
import 'package:quickdeal/src/presentation/features/auth/ui/widget/verify_email.dart';
import 'package:quickdeal/src/presentation/features/onboarding/onboarding.dart';

import '../../../../../core/router/routes.dart';
import '../../../../customs/custom_checkbox.dart';
import '../../../../customs/custom_elevated_button.dart';
import '../../../../customs/custom_outline_button.dart';
import '../../../../customs/custom_textformfield.dart';
import '../widget/forget_password.dart';

class SigninScreen extends ConsumerWidget {
  SigninScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var dark = context.isDarkMode;
    final signinState = ref.watch(signinStateProvider);
    final signinNotifier = ref.read(signinStateProvider.notifier);
    return Scaffold(
        backgroundColor: Colors.transparent,
        body: Column(
          children: [
            Expanded(
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.only(
                    topRight: Radius.circular(24),
                    topLeft: Radius.circular(24),
                  ),
                  color: dark ? CColors.darkContainer : CColors.white,
                ),
                child: Padding(
                  padding: const EdgeInsets.only(
                    left: 32,
                    right: 32,
                  ),
                  child: SingleChildScrollView(
                    child: Form(
                      key: signinNotifier.formKey,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            "Sign In",
                            style: Theme.of(context).textTheme.headlineLarge,
                          ),
                          Text(
                            "Sign in to my account",
                            style: Theme.of(context).textTheme.titleLarge,
                          ),
                          const SizedBox(height: 16),
                          CustomTextformField(
                            cont: signinState.emailController,
                            keyboardType: TextInputType.emailAddress,
                            decoration: const InputDecoration(
                              hintText: Texts.emailTitle,
                              prefixIcon: Icon(Icons.email_outlined),
                            ),
                          ),
                          const SizedBox(height: 24),
                          CustomTextformField(
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter password';
                              }
                              if (value.length < 6) {
                                return 'Password is short';
                              }
                              return null;
                            },
                            cont: signinState.passwordController,
                            keyboardType: TextInputType.visiblePassword,
                            decoration: const InputDecoration(
                                hintText: Texts.passwordTitle,
                                prefixIcon: Icon(Icons.password),
                                suffixIcon: Icon(Icons.remove_red_eye)),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const SizedBox(width: 16),
                              TextButton(
                                onPressed: () async {
                                  showModalBottomSheet(
                                    useSafeArea: true,
                                    context: context,
                                    isScrollControlled: true,
                                    builder: (context) {
                                      return ForgetPasswordScreen(
                                        onPress: () {
                                          context.pop(context);
                                          showModalBottomSheet(
                                            isScrollControlled: true,
                                            context: context,
                                            builder: (context) {
                                              return VerifyEmail(
                                                title: "Forgot  Password!",
                                                subtitle:
                                                    "A reset code has been sent to Tonald@work.com, check your email to continue the password reset process.",
                                                onPress: () {
                                                  context.pop(context);
                                                  showModalBottomSheet(
                                                    context: context,
                                                    isScrollControlled: true,
                                                    builder: (context) {
                                                      return VerifyEmail(
                                                        title:
                                                            "Set a New Password!",
                                                        subtitle:
                                                            "Please set a new password to secure your Work Mate account.",
                                                        onPress: () {
                                                          context.pop(context);

                                                          showModalBottomSheet(
                                                            context: context,
                                                            isScrollControlled:
                                                                true,
                                                            builder: (context) {
                                                              return SuccessScreen(
                                                                title:
                                                                    "Password Has Been created",
                                                                subtitle:
                                                                    "To log in to your account, click the Sign in button and enter your email along with your new password.",
                                                                onPress: () {
                                                                  context.pushNamed(
                                                                      Routes
                                                                          .signinScreen);
                                                                },
                                                              );
                                                            },
                                                          );
                                                        },
                                                      );
                                                    },
                                                  );
                                                },
                                              );
                                            },
                                          );
                                        },
                                      );
                                    },
                                  );
                                },
                                child: const Text(
                                  "Forgot Password?",
                                ),
                              )
                            ],
                          ),
                          const SizedBox(
                            height: Sizes.lg,
                          ),
                          MElevatedButton(
                            text: "Sign In",
                            onPress: () async {
                              final response = await signinNotifier.login();
                              if (response) {
                                context.pushNamedAndRemoveUntil(
                                    Routes.dashboardScreen,
                                    predicate: (route) => false);
                              }
                            },
                          ),
                          const SizedBox(
                            height: Sizes.xxl,
                          ),
                          Row(
                            children: [
                              Expanded(
                                  flex: 3,
                                  child: Container(
                                    width: double.infinity,
                                    color: dark ? Colors.white : CColors.black,
                                    height: 0.4.h,
                                  )),
                              const Expanded(
                                  flex: 1,
                                  child: Center(
                                    child: Text("OR"),
                                  )),
                              Expanded(
                                  flex: 3,
                                  child: Container(
                                    width: double.infinity,
                                    color: dark ? Colors.white : CColors.black,
                                    height: 0.4.h,
                                  )),
                            ],
                          ),
                          SizedBox(
                            height: Sizes.xl.h,
                          ),
                          MOutlinedButton(
                            onPress: () {},
                            text: "Sign in with Phone",
                          ),
                          SizedBox(
                            height: Sizes.md.h,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Dont't have an account?  ",
                                style: Theme.of(context).textTheme.titleMedium,
                              ),
                              TextButton(
                                  onPressed: () {
                                    context.pop();
                                  },
                                  child: const Text(
                                    "Sign Up Here",
                                    style: TextStyle(color: CColors.primary),
                                  ))
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            )
          ],
        ));
  }
}
