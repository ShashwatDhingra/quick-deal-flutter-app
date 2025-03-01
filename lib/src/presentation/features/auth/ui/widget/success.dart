import 'package:flutter/material.dart';
import '../../../../../core/utils/ui_utils/constants/sizes.dart';

class SuccessScreen extends StatelessWidget {
  const SuccessScreen({
    super.key,
    required this.onPress,
    required this.title,
    required this.subtitle,
  });

  final void Function() onPress;
  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    final bottomInset = MediaQuery.of(context).viewInsets.bottom;
    return LayoutBuilder(
      builder: (context, constraints) {
        return SingleChildScrollView(
          padding: EdgeInsets.only(
            left: 24,
            right: 24,
            top: 10,
            bottom: bottomInset > 0 ? bottomInset + 20 : 24,
          ),
          child: Column(
            children: [
              Text(
                title,
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              const SizedBox(height: Sizes.lg),
              Text(
                subtitle,
                textAlign: TextAlign.justify,
              ),
            ],
          ),
        );
      },
    );
  }
}
