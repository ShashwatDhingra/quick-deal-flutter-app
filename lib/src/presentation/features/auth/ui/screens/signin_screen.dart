import 'package:quickdeal/src/core/utils/ui_utils/extensions.dart';
import 'package:quickdeal/src/presentation/features/auth/states/signin_state.dart';
import 'package:quickdeal/src/presentation/features/auth/ui/widget/pin_sheet.dart';
import 'package:quickdeal/src/presentation/features/onboarding/onboarding.dart';

import '../../../../../core/router/routes.dart';
import '../../../../customs/custom_elevated_button.dart';
import '../../../../customs/custom_outline_button.dart';
import '../../../../customs/custom_textformfield.dart';
import '../widget/forget_password.dart';

class SigninScreen extends ConsumerStatefulWidget {
  const SigninScreen({super.key});

  @override
  ConsumerState<SigninScreen> createState() => _SigninScreenState();
}

class _SigninScreenState extends ConsumerState<SigninScreen>
    with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
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
                      key: signinNotifier.signinFormKey,
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
                                      return const ForgetPasswordScreen();
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
                          CustomElevatedButton(
                            text: "Sign In",
                            onPress: () async {
                              final response = await signinNotifier.login(ref);
                              if (response) {
                                // ignore: use_build_context_synchronously
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
                                style: Theme.of(context).textTheme.bodyMedium,
                              ),
                              TextButton(
                                  onPressed: () {
                                    context.pop();
                                    final bottomSheetController =
                                        AnimationController(
                                      vsync: this,
                                      duration:
                                          const Duration(milliseconds: 700),
                                    );

                                    showModalBottomSheet(
                                      isScrollControlled: true,
                                      context: context,
                                      transitionAnimationController:
                                          bottomSheetController,
                                      builder: (context) {
                                        return PinSheet(isSignup: true);
                                        // return FractionallySizedBox(
                                        //   heightFactor: 0.8,
                                        //   child: AnimatedBuilder(
                                        //     animation: bottomSheetController,
                                        //     builder: (context, child) {
                                        //       return child!;
                                        //     },
                                        //     child: SignupScreen(),
                                        //   ),
                                        // );
                                      },
                                    );
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
