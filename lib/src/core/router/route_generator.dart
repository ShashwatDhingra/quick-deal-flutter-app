import 'package:flutter/cupertino.dart';
import 'package:quickdeal/src/core/router/routes.dart';
import 'package:quickdeal/src/presentation/features/dashboard/subscreens/search/search_screen.dart';
import 'package:quickdeal/src/presentation/features/followup/followup_screen.dart';
import 'package:quickdeal/src/presentation/features/lead/lead_screen.dart';
import 'package:quickdeal/src/presentation/features/tearmConditon/tearm_condition_screen.dart';

import '../../presentation/features/about/about_us_screen.dart';
import '../../presentation/features/analytics._screen.dart';
import '../../presentation/features/auth/ui/screens/signin_screen.dart';
import '../../presentation/features/auth/ui/screens/signup_screen.dart';
import '../../presentation/features/dashboard/dashboard_screen.dart';
import '../../presentation/features/dashboard/subscreens/detail/detail_screen.dart';
import '../../presentation/features/faq/faq_screen.dart';
import '../../presentation/features/feedback/feedback_screen.dart';
import '../../presentation/features/lead/lead_form_screen.dart';
import '../../presentation/features/notification/notification_screen.dart';
import '../../presentation/features/onboarding/onboarding_screen.dart';
import '../../presentation/features/property/ui/screens/add_property.dart';

import '../../presentation/features/splashScreen/ui/splash_screen.dart';
import '../../presentation/help/help_support_screen.dart';
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
              const SigninScreen(),
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
              const SignupScreen(),
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

      // Add Property
      case Routes.addPropertyScreen:
        return MaterialPageRoute(
            builder: (context) => const AddPropertyScreen());

      // Properties Detail

      case Routes.propertyDetailScreen:
        return MaterialPageRoute(
            builder: (context) => const PropetyDetailScreen());

      // Lead List Screen
      case Routes.leadScreen:
        return MaterialPageRoute(builder: (context) => const LeadScreen());

      // Create Lead From Screen
      case Routes.createLeadFormScreen:
        return MaterialPageRoute(builder: (context) => const LeadFormScreen());

      // List of followup
      case Routes.followupScreen:
        return MaterialPageRoute(builder: (context) => const FollowupScreen());

      // List of notifications
      case Routes.notificationScreen:
        return MaterialPageRoute(
            builder: (context) => const NotificationScreen());

      // tearms of connditions page
      case Routes.termsAndConditionScreen:
        return MaterialPageRoute(
            builder: (context) => const TermsAndConditionsScreen());

      // FQuestions and questions
      case Routes.faqScreen:
        return MaterialPageRoute(builder: (context) => FAQScreen());

      // Feedback view screen
      case Routes.feedbackScreen:
        return MaterialPageRoute(
            builder: (context) => const FeedbackFormScreen());
      // help and support
      case Routes.helpAndSupportScreen:
        return MaterialPageRoute(
            builder: (context) => const HelpSupportScreen());

      // About us page
      case Routes.aboutUsScreen:
        return MaterialPageRoute(builder: (context) => const AboutUsScreen());

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
