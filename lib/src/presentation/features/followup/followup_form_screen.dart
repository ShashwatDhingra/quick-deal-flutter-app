import 'package:quickdeal/src/presentation/customs/custom_elevated_button.dart';
import 'package:quickdeal/src/presentation/features/dashboard/subscreens/profile/profile.dart';

import '../../customs/custom_select_field.dart';
import '../../customs/custom_textformfield.dart';
import 'states/followup_state.dart';

class LeadFormScreen extends ConsumerWidget {
  const LeadFormScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final followupState = ref.watch(followupStateProvider);
    final followupNotifier = ref.read(followupStateProvider.notifier);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Follow-Up"),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            Expanded(
              flex: 12,
              child: CustomElevatedButton(
                buttonColor: CColors.transparent,
                text: "Reset",
                onPress: () {
                  followupNotifier.clearAllControllers();
                },
              ),
            ),
            const Expanded(
              child: SizedBox(),
            ),
            Expanded(
              flex: 12,
              child: CustomElevatedButton(
                text: "Create",
                onPress: () {
                  followupNotifier.createFollowup(ref);
                },
              ),
            ),
          ],
        ),
      ),
      body: SafeArea(
        child: Form(
          key: followupNotifier.leadFormKey,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const Align(
                      alignment: Alignment.centerLeft, child: Text('Name')),
                  10.hBox,
                  CustomTextformField(
                      validator: (val) {
                        if (val == null || val.isEmpty) {
                          return 'Value cant be null';
                        }
                        return null;
                      },
                      cont: followupState.nameController,
                      labelText: 'Name *'),
                  16.hBox,
                  const Align(
                      alignment: Alignment.centerLeft, child: Text('Phone')),
                  10.hBox,
                  CustomTextformField(
                      keyboardType: TextInputType.phone,
                      validator: (val) {
                        if (val == null || val.isEmpty) {
                          return 'Phone cant be null';
                        }
                        return null;
                      },
                      cont: followupState.phoneController,
                      labelText: 'Phone *'),
                  16.hBox,
                  const Align(
                      alignment: Alignment.centerLeft, child: Text('Email')),
                  10.hBox,
                  CustomTextformField(
                      keyboardType: TextInputType.emailAddress,
                      validator: (val) {
                        if (val == null || val.isEmpty) {
                          return 'Email cant be null';
                        }
                        return null;
                      },
                      cont: followupState.emalController,
                      labelText: 'Email *'),

                  26.hBox,

                  CustomSelectField(
                    isMultiSelect: false,
                    options: const [
                      'Sale',
                      'Rent',
                    ],
                    selectedValue: followupState.status,
                    labelText: 'Status of Property',
                    onChanged: (value) {
                      followupState.status = value;
                    },
                    validator: (val) {
                      if (val == null || val.isEmpty) {
                        return 'Please select at least one Type';
                      }
                      return null;
                    },
                  ),
                  26.hBox,
                  CustomSelectField(
                    isMultiSelect: false,
                    options: const [
                      'Commercial',
                      'Office',
                      'Shop',
                      'Residential',
                      'Apartment',
                      'Studio',
                      'Villa'
                    ],
                    selectedValue: followupState.propertyCategory,
                    labelText: 'Type of Property',
                    onChanged: (value) {
                      followupState.propertyCategory = value;
                    },
                    validator: (val) {
                      if (val == null || val.isEmpty) {
                        return 'Please select at least one Type';
                      }
                      return null;
                    },
                  ),

                  16.hBox,
                  const Align(
                      alignment: Alignment.centerLeft, child: Text('Remarks')),
                  10.hBox,
                  CustomTextformField(
                      maxLines: 5,
                      validator: (val) {
                        if (val == null || val.isEmpty) {
                          return 'Remarks cant be null';
                        }
                        return null;
                      },
                      cont: followupState.remarksController,
                      labelText: 'Remarks *'),

                  //
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
