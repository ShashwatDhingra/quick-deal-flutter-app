import 'package:quickdeal/src/presentation/customs/custom_elevated_button.dart';
import 'package:quickdeal/src/presentation/features/dashboard/subscreens/profile/profile.dart';
import '../../customs/custom_select_field.dart';
import '../../customs/custom_textformfield.dart';
import 'states/lead_state.dart';

class LeadFormScreen extends ConsumerWidget {
  const LeadFormScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final leadPageState = ref.watch(leadStateProvider);
    final leadPageNotifier = ref.read(leadStateProvider.notifier);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Create Lead"),
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
                  leadPageNotifier.clearAllControllers();
                },
              ),
            ),
            const Expanded(
              child: SizedBox(),
            ),
            Expanded(
              flex: 12,
              child: CustomElevatedButton(
                text: Texts.create,
                onPress: () {
                  leadPageNotifier.createLead(ref);
                },
              ),
            ),
          ],
        ),
      ),
      body: SafeArea(
        child: Form(
          key: leadPageNotifier.leadFormKey,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  // Name and Phone side by side
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text('Name'),
                              10.hBox,
                              CustomTextformField(
                                  validator: (val) {
                                    if (val == null || val.isEmpty) {
                                      return 'Value cant be null';
                                    }
                                    return null;
                                  },
                                  cont: leadPageState.nameController,
                                  labelText: 'Name *'),
                            ]),
                      ),
                      16.vBox,
                      Expanded(
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text('Phone'),
                              10.hBox,
                              CustomTextformField(
                                  keyboardType: TextInputType.phone,
                                  validator: (val) {
                                    if (val == null || val.isEmpty) {
                                      return 'Phone cant be null';
                                    }
                                    return null;
                                  },
                                  cont: leadPageState.phoneController,
                                  labelText: 'Phone *'),
                            ]),
                      ),
                    ],
                  ),
                  16.hBox,
                  // Email field
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
                      cont: leadPageState.emalController,
                      labelText: 'Email *'),

                  26.hBox,

                  // Status of Property and Type of Property side by side
                  Row(
                    children: [
                      Expanded(
                        child: CustomSelectField(
                          isMultiSelect: false,
                          options: const [
                            'Sale',
                            'Rent',
                          ],
                          selectedValue: leadPageState.status,
                          labelText: 'Status of Property',
                          onChanged: (value) {
                            leadPageState.status = value;
                          },
                          validator: (val) {
                            if (val == null || val.isEmpty) {
                              return 'Please select at least one Type';
                            }
                            return null;
                          },
                        ),
                      ),
                      16.vBox,
                      Expanded(
                        child: CustomSelectField(
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
                          selectedValue: leadPageState.propertyCategory,
                          labelText: 'Type of Property',
                          onChanged: (value) {
                            leadPageState.propertyCategory = value;
                          },
                          validator: (val) {
                            if (val == null || val.isEmpty) {
                              return 'Please select at least one Type';
                            }
                            return null;
                          },
                        ),
                      ),
                    ],
                  ),

                  16.hBox,
                  // Remarks field
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
                      cont: leadPageState.remarksController,
                      labelText: 'Remarks *'),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
