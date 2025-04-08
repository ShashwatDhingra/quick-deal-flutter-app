
import '../dashboard/subscreens/profile/profile.dart';

class TermsAndConditionsScreen extends StatelessWidget {
  const TermsAndConditionsScreen({super.key});

  @override
  Widget build(BuildContext context) {
   
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          Texts.termsAndConditions,
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: CColors.primary,
        elevation: 0,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Last Updated: October 2023',
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey,
                fontStyle: FontStyle.italic,
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              '1. Introduction',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: CColors.primary,
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              'Welcome to our app. By using our services, you agree to these terms and conditions. Please read them carefully.',
              //  style: Theme.of(context).textTheme.bodyText2,
            ),
            const SizedBox(height: 20),
            const Text(
              '2. User Responsibilities',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: CColors.primary,
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              'You are responsible for maintaining the confidentiality of your account and password. You agree to accept responsibility for all activities that occur under your account.',

              /// style: Theme.of(context).textTheme.bodyText2,
            ),
            const SizedBox(height: 20),
            const Text(
              '3. Privacy Policy',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: CColors.primary,
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              'Your use of our app is also governed by our Privacy Policy. Please review our Privacy Policy to understand our practices.',
              //   style: Theme.of(context).textTheme.bodyText2,
            ),
            const SizedBox(height: 20),
            const Text(
              '4. Limitation of Liability',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: CColors.primary,
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              'We shall not be liable for any indirect, incidental, special, consequential, or punitive damages, including without limitation, loss of profits, data, or use.',
              // style: Theme.of(context).textTheme.bodyText2,
            ),
            const SizedBox(height: 20),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  // Navigate to the next screen or close the dialog
                  Navigator.pop(context);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: CColors.primary,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                child: const Text(
                  'Accept',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
