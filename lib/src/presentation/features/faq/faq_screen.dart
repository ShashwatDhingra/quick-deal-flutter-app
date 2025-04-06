
import '../dashboard/subscreens/profile/profile.dart';

class FAQScreen extends StatelessWidget {
  final List<FAQItem> faqItems = [
    FAQItem(
      question: 'How do I create an account?',
      answer:
          'To create an account, go to the Sign Up page and enter your details. Once completed, you will receive a confirmation email.',
    ),
    FAQItem(
      question: 'How can I reset my password?',
      answer:
          'You can reset your password by clicking on the "Forgot Password" link on the login page. Follow the instructions sent to your email.',
    ),
    FAQItem(
      question: 'Is my data secure?',
      answer:
          'Yes, we use industry-standard encryption to ensure your data is safe and secure.',
    ),
    FAQItem(
      question: 'How do I contact support?',
      answer:
          'You can contact our support team by emailing support@example.com or using the in-app chat feature.',
    ),
  ];

  FAQScreen({super.key});

  @override
  Widget build(BuildContext context) {
 

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'FAQs',
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
              'Frequently Asked Questions',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: CColors.primary,
              ),
            ),
            const SizedBox(height: 20),
            ...faqItems.map((item) => FAQWidget(item: item)),
          ],
        ),
      ),
    );
  }
}

class FAQItem {
  final String question;
  final String answer;

  FAQItem({required this.question, required this.answer});
}

class FAQWidget extends StatelessWidget {
  final FAQItem item;

  const FAQWidget({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    var isDark = context.isDarkMode;
    return ExpansionTile(
      iconColor: isDark ? CColors.textWhite : CColors.primary,
      title: Text(
        item.question,
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: isDark ? CColors.textWhite : CColors.primary,
        ),
      ),
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          child: Text(
            item.answer,
            style: TextStyle(
              fontSize: 14.sp,
              color: isDark ? CColors.textWhite : Colors.black87,
            ),
          ),
        ),
      ],
    );
  }
}
