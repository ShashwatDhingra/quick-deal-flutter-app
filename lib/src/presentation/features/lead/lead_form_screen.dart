import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:quickdeal/src/presentation/customs/custom_elevated_button.dart';
import 'package:quickdeal/src/presentation/features/dashboard/subscreens/profile/profile.dart';

import '../../customs/custom_textformfield.dart';
import 'states/lead_state.dart';

class LeadFormScreen extends ConsumerWidget {
  const LeadFormScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final leadPageState = ref.watch(leadStateProvider);
    final firstPageNotifier = ref.read(leadStateProvider.notifier);
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
                onPress: () {},
              ),
            ),
            const Expanded(
              child: SizedBox(),
            ),
            Expanded(
              flex: 12,
              child: CustomElevatedButton(
                text: "Create",
                onPress: () {},
              ),
            ),
          ],
        ),
      ),
      body: SafeArea(
        child: Form(
          key: firstPageNotifier.leadFormKey,
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
                      cont: leadPageState.nameController,
                      labelText: 'Name *'),
                  16.hBox,
                  const Align(
                      alignment: Alignment.centerLeft, child: Text('Phone')),
                  10.hBox,
                  CustomTextformField(
                      validator: (val) {
                        if (val == null || val.isEmpty) {
                          return 'Phone cant be null';
                        }
                        return null;
                      },
                      cont: leadPageState.phoneController,
                      labelText: 'Phone *'),
                  16.hBox,
                  const Align(
                      alignment: Alignment.centerLeft, child: Text('Email')),
                  10.hBox,
                  CustomTextformField(
                      validator: (val) {
                        if (val == null || val.isEmpty) {
                          return 'Email cant be null';
                        }
                        return null;
                      },
                      cont: leadPageState.emalController,
                      labelText: 'Email *'),

                  16.hBox,
                  const Align(
                      alignment: Alignment.centerLeft, child: Text('Remarks')),
                  10.hBox,
                  CustomTextformField(
                      validator: (val) {
                        if (val == null || val.isEmpty) {
                          return 'Remarks cant be null';
                        }
                        return null;
                      },
                      cont: leadPageState.remarksController,
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
