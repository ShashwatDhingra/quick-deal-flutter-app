import 'package:quickdeal/src/core/utils/ui_utils/extensions.dart';

import '../../../core/utils/ui_utils/constants/assets.dart';
import '../../customs/custom_elevated_button.dart';
import '../../customs/custom_outline_button.dart';
import '../auth/ui/screens/signin_screen.dart';
import '../auth/ui/screens/signup_screen.dart';
import 'onboarding.dart';
import 'onboarding_state.dart';

class OnboardingScreen extends ConsumerStatefulWidget {
  const OnboardingScreen({super.key});

  @override
  ConsumerState<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends ConsumerState<OnboardingScreen>
    with TickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: 2.seconds,
    )..repeat(reverse: true); // Repeats animation back and forth

    _animation = Tween<double>(begin: -10.0, end: 10.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final onboardingState = ref.watch(onboardingStateProvider);
    final onboardingNotifier = ref.read(onboardingStateProvider.notifier);
    final dark = context.isDarkMode;
    return Scaffold(
        body: Padding(
      padding: const EdgeInsets.only(bottom: 24.0),
      child: Column(
        children: [
          Expanded(
            flex: 2,
            child: Stack(
              children: [
                Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: dark
                          ? [CColors.black, CColors.black]
                          : [
                              CColors.primary,
                              Colors.white
                            ], // Define gradient colors here
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(54.0),
                  child: Align(
                    alignment: Alignment.center,
                    child: AnimatedBuilder(
                      animation: _animation,
                      builder: (context, child) {
                        return Transform.translate(
                          offset: Offset(0, _animation.value),
                          child: child,
                        );
                      },
                      child: Image.asset(AssetsConsts.onboardingIllus),
                    ),
                  ),
                ),
                SafeArea(
                  child: Padding(
                    padding: const EdgeInsets.only(right: 14.0),
                    child: 
                    Align(
                        alignment: Alignment.topRight,
                        child: GestureDetector(
                          onTap: () {
                            onboardingNotifier.skipToLastPage();
                          },
                          child: Text('Skip',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyLarge!
                                  .copyWith(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold)),
                        )).showIf(onboardingState.currentIndex!= 3)
                 
                
                  ),
                )
              ],
            ),
          ),
          Expanded(
            flex: 1,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Column(
                    children: [
                      if (onboardingState.currentIndex < 3)
                        SizedBox(
                          width: double.infinity,
                          height: 10,
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: List.generate(
                                onboardingState.onBoardingMessageTitle.length -
                                    1,
                                (index) {
                                  return AnimatedContainer(
                                    duration: const Duration(milliseconds: 300),
                                    margin: const EdgeInsets.symmetric(
                                        horizontal: 4.0),
                                    height: 3.0,
                                    width: onboardingState.currentIndex == index
                                        ? 20.0
                                        : 20.0,
                                    decoration: BoxDecoration(
                                      color:
                                          onboardingState.currentIndex == index
                                              ? CColors.primary
                                              : Colors.grey,
                                      borderRadius: BorderRadius.circular(4.0),
                                    ),
                                  );
                                },
                              )),
                        ),
                      6.hBox,
                      Center(
                        child: AnimatedSwitcher(
                          duration: const Duration(milliseconds: 700),
                          reverseDuration: const Duration(milliseconds: 400),
                          transitionBuilder:
                              (Widget child, Animation<double> animation) {
                            return Stack(
                              children: [
                                FadeTransition(
                                  opacity: animation,
                                  child: ScaleTransition(
                                    scale: Tween<double>(begin: 0.95, end: 1.0)
                                        .animate(
                                      CurvedAnimation(
                                        parent: animation,
                                        curve: Curves.easeOutBack,
                                      ),
                                    ),
                                    child: SlideTransition(
                                      position: Tween<Offset>(
                                        begin: const Offset(0.0, 0.3),
                                        end: Offset.zero,
                                      ).animate(
                                        CurvedAnimation(
                                          parent: animation,
                                          curve: Curves.easeInOut,
                                        ),
                                      ),
                                      child: child,
                                    ),
                                  ),
                                ),
                              ],
                            );
                          },
                          child: Text(
                            onboardingState.onBoardingMessageTitle[
                                onboardingState.currentIndex],
                            key: ValueKey(onboardingState.currentIndex),
                            textAlign: TextAlign.center,
                            style: Theme.of(context).textTheme.headlineMedium,
                          ),
                        ),
                      ),
                      const SizedBox(height: Sizes.sm),
                      AnimatedSwitcher(
                        duration: const Duration(milliseconds: 700),
                        reverseDuration: const Duration(milliseconds: 400),
                        transitionBuilder:
                            (Widget child, Animation<double> animation) {
                          return Stack(
                            children: [
                              FadeTransition(
                                opacity: animation,
                                child: SlideTransition(
                                  position: Tween<Offset>(
                                    begin: const Offset(0.0, -0.2),
                                    end: Offset.zero,
                                  ).animate(
                                    CurvedAnimation(
                                      parent: animation,
                                      curve: Curves.easeOut,
                                    ),
                                  ),
                                  child: child,
                                ),
                              ),
                            ],
                          );
                        },
                        child: Text(
                          onboardingState.onBoardingMessageSubtitles[
                              onboardingState.currentIndex],
                          key: ValueKey(onboardingState.currentIndex),
                          textAlign: TextAlign.center,
                          style: Theme.of(context)
                              .textTheme
                              .titleLarge!
                              .copyWith(
                                  color:
                                      dark ? CColors.light : CColors.primary),
                        ),
                      ),
                    ],
                  ),
                  const Spacer(), // Push buttons to the bottom
                  CustomElevatedButton(
                    text: onboardingState.currentIndex != 3
                        ? 'Next'
                        : Texts.signIn,
                    onPress: () {
                      if (onboardingState.currentIndex == 2) {
                        onboardingNotifier.skipToLastPage();
                      }
                      if (onboardingState.currentIndex < 3) {
                        onboardingNotifier.nextPage();
                        return;
                      }
                      final bottomSheetController = AnimationController(
                        vsync: this,
                        duration: const Duration(milliseconds: 700),
                      );

                      showModalBottomSheet(
                        isScrollControlled: true,
                        context: context,
                        transitionAnimationController: bottomSheetController,
                        builder: (context) {
                          return FractionallySizedBox(
                            heightFactor: 0.8,
                            child: AnimatedBuilder(
                              animation: bottomSheetController,
                              builder: (context, child) {
                                return child!;
                              },
                              child: const SigninScreen(),
                            ),
                          );
                        },
                      );
                    },
                  ),
                  const SizedBox(height: Sizes.md),
                  MOutlinedButton(
                    text: onboardingState.currentIndex < 3
                        ? 'Previous'
                        : Texts.signUp,
                    onPress: () {
                      if (onboardingState.currentIndex == 0) {
                        return;
                      }
                      if (onboardingState.currentIndex < 3) {
                        onboardingNotifier.preiousPage();
                        return;
                      }
                      final bottomSheetController = AnimationController(
                        vsync: this,
                        duration: const Duration(milliseconds: 700),
                      );

                      showModalBottomSheet(
                        isScrollControlled: true,
                        context: context,
                        transitionAnimationController: bottomSheetController,
                        builder: (context) {
                          return FractionallySizedBox(
                            heightFactor: 0.8,
                            child: AnimatedBuilder(
                              animation: bottomSheetController,
                              builder: (context, child) {
                                return child!;
                              },
                              child: const SignupScreen(),
                            ),
                          );
                        },
                      );
                    },
                  ),
                  const SizedBox(height: 24.0),
                ],
              ),
            ),
          )
        ],
      ),
    ));
  }
}
