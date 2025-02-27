import 'package:flutter/material.dart';
import 'package:quickdeal/src/core/utils/ui_utils/extensions.dart';

import '../../../../customs/custom_elevated_button.dart';
import '../../../../customs/custom_outline_button.dart';

class TermsConditionScreen extends StatelessWidget {
  const TermsConditionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0),
      child: Column(
        children: [
          const Text(
            'Terms & Conditions and Privacy Policy',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 24),
          const Text(
              textAlign: TextAlign.center,
              "There are many variations of passages of Lorem Ipsum available,\n but the majority have suffered alteration in some form, by injected humour, or randomised words which don't look even slightly believable. If you are going to use a passage of Lorem Ipsum, you need to be sure there isn't anything embarrassing hidden in the middle of text. All the Lorem Ipsum generators on the Internet tend to repeat predefined chunks as necessary, making this the first true generator on the Internet. It uses a dictionary of over 200 Latin words, combined with a handful of model sentence structures, to generate Lorem Ipsum which looks reasonable. The generated Lorem Ipsum is therefore always free from repetition, injected humour, or non-characteristic words etc."),
          Expanded(
              child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 36),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                CustomElevatedButton(
                  text: "i Agree",
                  onPress: () {
                    context.pop();
                  },
                ),
                const SizedBox(height: 12),
                MOutlinedButton(
                  text: "Decline",
                  onPress: () {
                    context.pop();
                  },
                )
              ],
            ),
          ))
        ],
      ),
    );
  }
}
