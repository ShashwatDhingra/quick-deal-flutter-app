import 'package:ease_x/ease_x.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:quickdeal/src/presentation/customs/custom_select_field.dart';
import 'package:quickdeal/src/presentation/customs/custom_textformfield.dart';
import 'package:quickdeal/src/presentation/features/property/states/property_list_state.dart';

import '../../../../../core/utils/ui_utils/constants/text_strings.dart';

class PropertyListFilter extends ConsumerStatefulWidget {
  const PropertyListFilter({super.key});

  @override
  ConsumerState<PropertyListFilter> createState() => _PropertyListFilterState();
}

class _PropertyListFilterState extends ConsumerState<PropertyListFilter> {
  late TextEditingController minPriceController;
  late TextEditingController maxPriceController;
  late TextEditingController bedroomController;
  late TextEditingController bathroomController;
  late TextEditingController constructionYearController;
  late TextEditingController cityController;
  late TextEditingController stateController;
  late TextEditingController pincodeController;

  @override
  void initState() {
    super.initState();
    final propertyState = ref.read(propertyStateProvider);
    minPriceController = TextEditingController(
        text: propertyState.propertyFilter.minPrice?.toString() ?? '');
    maxPriceController = TextEditingController(
        text: propertyState.propertyFilter.maxPrice?.toString() ?? '');
    bedroomController = TextEditingController(
        text: propertyState.propertyFilter.bedrooms?.toString() ?? '');
    bathroomController = TextEditingController(
        text: propertyState.propertyFilter.bathrooms?.toString() ?? '');
    constructionYearController = TextEditingController(
        text: propertyState.propertyFilter.constructionYear?.toString() ?? '');
    cityController = TextEditingController(
        text: propertyState.propertyFilter.city?.toString() ?? '');
    stateController = TextEditingController(
        text: propertyState.propertyFilter.state?.toString() ?? '');
    pincodeController = TextEditingController(
        text: propertyState.propertyFilter.pincode?.toString() ?? '');
  }

  @override
  void dispose() {
    minPriceController.dispose();
    maxPriceController.dispose();
    bedroomController.dispose();
    bathroomController.dispose();
    constructionYearController.dispose();
    cityController.dispose();
    stateController.dispose();
    pincodeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final propertyState = ref.read(propertyStateProvider);
    final propertyStateNotifier = ref.read(propertyStateProvider.notifier);

    return StatefulBuilder(
      builder: (context, setState) {
        return Padding(
          padding: EdgeInsets.only(
            left: 16,
            right: 16,
            top: 16,
            bottom: MediaQuery.of(context).viewInsets.bottom + 16,
          ),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text("Filter Properties",
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold))
                    .centered(),
                18.vBox,
                CustomSelectField(
                  options: const [
                    'Commercial',
                    'Office',
                    'Shop',
                    'Residential',
                    'Apartment',
                    'Studio',
                    'Villa'
                  ],
                  selectedValue: propertyState.propertyFilter.propertyType,
                  onChanged: (value) {
                    if (kDebugMode) {
                      print('value$value');
                    }
                    propertyStateNotifier.applyfilter(
                      propertyState.propertyFilter
                          .copyWith(propertyType: value),
                    );
                  },
                  labelText: 'Type of Property',
                  isMultiSelect: true,
                ),
                12.vBox,
                // Price Range
                Row(
                  children: [
                    Expanded(
                      child: CustomTextformField(
                        cont: minPriceController,
                        labelText: 'Min Price',
                        keyboardType: TextInputType.number,
                        onChanged: (value) {
                          propertyStateNotifier.applyfilter(
                            propertyState.propertyFilter.copyWith(
                                minPrice: double.tryParse(value) ?? 0),
                          );
                        },
                      ),
                    ),
                    20.hBox,
                    Expanded(
                      child: CustomTextformField(
                        cont: TextEditingController(),
                        labelText: 'Max Price',
                        keyboardType: TextInputType.number,
                      ),
                    ),
                  ],
                ),
                12.vBox,
                CustomSelectField(
                  options: const ['Sale', 'Rent'],
                  selectedValue: propertyState.propertyFilter.status,
                  onChanged: (val) {
                    propertyStateNotifier.applyfilter(
                      propertyState.propertyFilter.copyWith(status: val),
                    );
                  },
                  labelText: 'Status',
                  isMultiSelect: true,
                ),
                12.vBox,

                // Bedrooms and Bathrooms
                Row(
                  children: [
                    Expanded(
                      child: CustomTextformField(
                        cont: TextEditingController(),
                        labelText: 'Bedrooms',
                        keyboardType: TextInputType.number,
                      ),
                    ),
                    20.hBox,
                    Expanded(
                      child: CustomTextformField(
                        cont: TextEditingController(),
                        labelText: 'Bathrooms',
                        keyboardType: TextInputType.number,
                      ),
                    ),
                  ],
                ),
                12.vBox,

                // Construction Year
                CustomTextformField(
                  cont: TextEditingController(),
                  labelText: 'Construction Year',
                  keyboardType: TextInputType.number,
                ),
                12.vBox,

                // Location Fields (City, Pincode, State)
                CustomTextformField(
                  cont: TextEditingController(),
                  labelText: 'City',
                  keyboardType: TextInputType.name,
                ),
                12.vBox,
                CustomTextformField(
                  cont: TextEditingController(),
                  labelText: 'State',
                  keyboardType: TextInputType.name,
                ),
                12.vBox,
                CustomTextformField(
                  cont: pincodeController,
                  labelText: 'Pincode',
                  keyboardType: TextInputType.number,
                  onChanged: (value) {
                    propertyStateNotifier.applyfilter(
                        propertyState.propertyFilter.copyWith(pincode: value));
                  },
                ),
                12.vBox,

                // Buttons
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: const Text(Texts.cancel),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
                        propertyStateNotifier.fetchProperties();
                      },
                      child: const Text(Texts.apply),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
