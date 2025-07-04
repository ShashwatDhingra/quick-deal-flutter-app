import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:quickdeal/src/core/utils/ui_utils/extensions.dart';
import 'package:quickdeal/src/presentation/features/property/states/first_page_state.dart';

import '../../../../../../core/utils/ui_utils/constants/text_strings.dart';
import '../../../../../customs/custom_select_field.dart';
import '../../../../../customs/custom_textformfield.dart';

class FirstPage extends ConsumerWidget {
  const FirstPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final firstPageState = ref.watch(firstPageStateProvider);
    final firstPageNotifier = ref.read(firstPageStateProvider.notifier);
    return Form(
      key: firstPageNotifier.firstPageFormKey,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(children: [
            const Align(
                alignment: Alignment.centerLeft, child: Text(Texts.desc)),
            16.hBox,
            CustomTextformField(
                validator: (val) {
                  if (val == null || val.isEmpty) {
                    return 'Value cant be null';
                  }
                  return null;
                },
                cont: firstPageState.propertyTitleController,
                labelText: 'Property Title *'),
            16.hBox,
            CustomTextformField(
              cont: firstPageState.contentController,
              labelText: 'Content',
              keyboardType: TextInputType.multiline,
              minLines: 10,
              maxLines: 10,
            ),
            16.hBox,
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
              selectedValue: firstPageState.propertyCategory,
              labelText: 'Type of Property',
              onChanged: (value) {
                firstPageNotifier.updatePropertyTypeList(value);
              },
              validator: (val) {
                if (val == null || val.isEmpty) {
                  return 'Please select at least one Type';
                }
                return null;
              },
            ),
            16.hBox,
            CustomSelectField(
              options: const ['Rent', 'Sale'],
              selectedValue: firstPageState.statusList,
              labelText: 'Status',
              onChanged: (values) {
                firstPageNotifier.updateStatusTypeList(values);
              },
              validator: (val) {
                if (val == null || val.isEmpty) {
                  return 'Please select at least one Option';
                }
                return null;
              },
            ),
            16.hBox,
            const Align(alignment: Alignment.centerLeft, child: Text('Price')),
            16.hBox,
            CustomTextformField(
              cont: firstPageState.priceController,
              keyboardType: TextInputType.number,
              labelText: 'Price',
              validator: (val) {
                if (val == null || val.isEmpty) {
                  return 'Please enter the Price.';
                }
                return null;
              },
            ),
            16.hBox,
            CustomTextformField(
              cont: firstPageState.rentIncController,
              keyboardType: TextInputType.number,
              labelText: 'Rent Increment % Per Year',
            ),
          ]),
        ),
      ),
    );
  }
}
