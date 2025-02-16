import 'package:flutter/cupertino.dart';
import 'package:quickdeal/src/core/router/routes.dart';
import 'package:quickdeal/src/presentation/features/dashboard/subscreens/search/search_screen.dart';

import '../../presentation/features/analytics._screen.dart';
import '../../presentation/features/auth/ui/screens/signin_screen.dart';
import '../../presentation/features/auth/ui/screens/signup_screen.dart';
import '../../presentation/features/dashboard/dashboard_screen.dart';
import '../../presentation/features/notification/notification_screen.dart';
import '../../presentation/features/onboarding/onboarding_screen.dart';
import '../../presentation/features/splashScreen/ui/splash_screen.dart';
import 'router.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    // final args = settings.arguments;
    switch (settings.name) {
      case Routes.splashScreen:
        return MaterialPageRoute(builder: (context) => const SplashScreen());
      // case Routes.introView:
      //   return MaterialPageRoute(builder: (context) => IntroView());
      // case Routes.confirmMailView:
      //   return MaterialPageRoute(
      //       builder: (context) =>
      //           ConfirmMailView(previousScreen: args.toString()));
      // case Routes.optView:
      //   args as Map<String, String>;
      //   return MaterialPageRoute(
      //       builder: (context) => OptView(
      //             email: args['email']!,
      //             previousScreen: args['previousScreen']!,
      //           ));
      // case Routes.signupView:
      //   return MaterialPageRoute(
      //       builder: (context) => SignupView(mail: args.toString()));
      case Routes.onboardingScreen:
        return MaterialPageRoute(
            builder: (context) => const OnboardingScreen());
      case Routes.signinScreen:
        return PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) =>
              SigninScreen(),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            const begin = Offset(0.0, 1.0); // Start from bottom
            const end = Offset.zero; // End at current position
            const curve = Curves.easeInOut;

            var tween =
                Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
            var offsetAnimation = animation.drive(tween);

            return SlideTransition(
              position: offsetAnimation,
              child: child,
            );
          },
        );

      case Routes.signupScreen:
        return PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) =>
              SignupScreen(),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            const begin = Offset(0.0, 1.0); // Start from bottom
            const end = Offset.zero; // End at current position
            const curve = Curves.easeInOut;

            var tween =
                Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
            var offsetAnimation = animation.drive(tween);

            return SlideTransition(
              position: offsetAnimation,
              child: child,
            );
          },
        );

      case Routes.dashboardScreen:
        return MaterialPageRoute(builder: (context) => const Dashboard());

      case Routes.notificationsScreen:
        return MaterialPageRoute(
            builder: (context) => const NotificationScreen());

      case Routes.searchScreen:
        return MaterialPageRoute(builder: (context) => const SearchScreen());

      // Analytics Screen
      case Routes.analyticScreen:
        return MaterialPageRoute(builder: (context) => const AnalyticsScreen());

      default:
        return _errorRoute();
    }
  }

  static Route<dynamic> _errorRoute() {
    return CupertinoPageRoute(
      builder: (context) {
        return Scaffold(
            appBar: AppBar(title: const Text('ERROR')),
            body: const Center(child: Text('ERROR')));
      },
    );
  }
}
