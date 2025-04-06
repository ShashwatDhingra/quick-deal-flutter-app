import 'package:quickdeal/src/presentation/customs/custom_elevated_button.dart';
import 'package:quickdeal/src/presentation/customs/custom_textformfield.dart';
import 'package:quickdeal/src/presentation/features/dashboard/subscreens/profile/profile.dart';

import 'state/feedback_state.dart';


class FeedbackFormScreen extends ConsumerWidget {
  const FeedbackFormScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final feedbackState = ref.watch(feedbackStateProvider);
    final feedbackNotifier = ref.read(feedbackStateProvider.notifier);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Submit Feedback"),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            Expanded(
              flex: 12,
              child: CustomElevatedButton(
                buttonColor: CColors.transparent,
                text: Texts.res,
                onPress: () {
                  feedbackNotifier.clearAllControllers();
                },
              ),
            ),
            const Expanded(
              child: SizedBox(),
            ),
            Expanded(
              flex: 12,
              child: CustomElevatedButton(
                text: Texts.submit,
                onPress: () {
                  feedbackNotifier.submitFeedback(ref);
                },
              ),
            ),
          ],
        ),
      ),
      body: SafeArea(
        child: Form(
          key: feedbackNotifier.feedbackFormKey,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  // Rating Input
                  const Align(
                    alignment: Alignment.centerLeft,
                    child: Text('Overall Rating'),
                  ),
                  10.hBox,
                  Slider(
                    value: feedbackState.rating,
                    min: 0,
                    max: 5,
                    divisions: 5,
                    label: feedbackState.rating.toString(),
                    onChanged: (value) {
                      feedbackNotifier.updateRating(value);
                    },
                  ),
                  16.hBox,

                  // Feedback Questions
                  const Align(
                    alignment: Alignment.centerLeft,
                    child: Text('How was your experience?'),
                  ),
                  10.hBox,
                  CustomTextformField(
                    maxLines: 3,
                    validator: (val) {
                      if (val == null || val.isEmpty) {
                        return 'Please share your experience';
                      }
                      return null;
                    },
                    cont: feedbackState.experienceController,
                    labelText: 'Your Experience *',
                  ),
                  16.hBox,

                  const Align(
                    alignment: Alignment.centerLeft,
                    child: Text('What can we improve?'),
                  ),
                  10.hBox,
                  CustomTextformField(
                    maxLines: 3,
                    validator: (val) {
                      if (val == null || val.isEmpty) {
                        return 'Please provide suggestions';
                      }
                      return null;
                    },
                    cont: feedbackState.improvementController,
                    labelText: 'Suggestions *',
                  ),
                  16.hBox,

                  // Additional Feedback
                  const Align(
                    alignment: Alignment.centerLeft,
                    child: Text('Additional Comments'),
                  ),
                  10.hBox,
                  CustomTextformField(
                    maxLines: 5,
                    cont: feedbackState.commentsController,
                    labelText: 'Additional Comments',
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}