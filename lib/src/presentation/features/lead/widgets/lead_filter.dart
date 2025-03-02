import 'package:flutter/material.dart';
import 'package:quickdeal/src/core/utils/ui_utils/extensions.dart';

import '../../../../core/utils/ui_utils/constants/sizes.dart';

class FilterBottomSheet extends StatefulWidget {
  const FilterBottomSheet({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _FilterBottomSheetState createState() => _FilterBottomSheetState();
}

class _FilterBottomSheetState extends State<FilterBottomSheet> {
  String? selectedCategory;
  RangeValues priceRange = const RangeValues(10, 100);
  String? selectedBrand;
  double selectedRating = 4.0;
  String? sortBy;

  final List<String> leadStatus = [
    "Draft",
    "Contacted",
    "Interested",
    "Not interested"
  ];
  final List<String> propertyStatus = ["Sale", "Rent"];
  final List<String> propertyCategory = [
    'Commercial',
    'Office',
    'Shop',
    'Residential',
    'Apartment',
    'Studio',
    'Villa'
  ];

  final List<String> sortOptions = [
    "Des",
    "Asc",
  ];

  bool week = true;
  @override
  Widget build(BuildContext context) {
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
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              "Filters",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const Divider(),
            const SizedBox(height: Sizes.cardRadiusSm),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Start on",
                  style:
                      TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w600),
                ),
                IconButton(
                    onPressed: () {
                      week = !week;
                      setState(() {});
                    },
                    icon: const Icon(Icons.change_circle_outlined))
              ],
            ),

            (Sizes.cardRadiusSm * 2).hBox,
            Text(
              "Category",
              style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w600),
            ),
            Wrap(
                spacing: 8,
                children: List.generate(
                  propertyCategory.length,
                  (index) {
                    return FilterChip(
                      label: Text(propertyCategory[index]),
                      selected: selectedCategory == propertyCategory[index],
                      onSelected: (bool selected) {
                        setState(() {
                          selectedCategory = propertyCategory[index];
                        });
                      },
                    );
                  },
                )),

            (Sizes.cardRadiusSm * 2).hBox,

            Text(
              "Price Range",
              style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w600),
            ),
            RangeSlider(
              values: priceRange,
              min: 0,
              max: 200,
              divisions: 20,
              labels: RangeLabels(
                "\$${priceRange.start.toInt()}",
                "\$${priceRange.end.toInt()}",
              ),
              onChanged: (RangeValues values) {
                setState(() {
                  priceRange = values;
                });
              },
            ),
            (Sizes.cardRadiusSm * 2).hBox,
            Text(
              "Status",
              style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w600),
            ),
            DropdownButton<String>(
              value: selectedBrand,
              isExpanded: true,
              hint: const Text("Select a Status"),
              items: propertyStatus.map((status) {
                return DropdownMenuItem<String>(
                  value: status,
                  child: Text(status),
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  selectedBrand = value;
                });
              },
            ),
            (Sizes.cardRadiusSm * 2).hBox,

            Text(
              "Lead Status",
              style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w600),
            ),
            DropdownButton<String>(
              value: selectedBrand,
              isExpanded: true,
              hint: const Text("Select a brand"),
              items: leadStatus.map((brand) {
                return DropdownMenuItem<String>(
                  value: brand,
                  child: Text(brand),
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  selectedBrand = value;
                });
              },
            ),

            (Sizes.cardRadiusSm * 2).hBox,

            // Rating Filter
            Text(
              "Minimum Rating",
              style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w600),
            ),
            Slider(
              value: selectedRating,
              min: 1.0,
              max: 5.0,
              divisions: 4,
              label: selectedRating.toString(),
              onChanged: (value) {
                setState(() {
                  selectedRating = value;
                });
              },
            ),

            (Sizes.cardRadiusSm * 2).hBox,

            Text(
              "Created By",
              style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w600),
            ),
            DropdownButton<String>(
              value: sortBy,
              isExpanded: true,
              hint: const Text("Sort items"),
              items: sortOptions.map((option) {
                return DropdownMenuItem<String>(
                  value: option,
                  child: Text(option),
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  sortBy = value;
                });
              },
            ),

            (Sizes.cardRadiusSm * 2).hBox,

            // Buttons
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () {
                      setState(() {
                        selectedCategory = null;
                        priceRange = const RangeValues(10, 100);
                        selectedBrand = null;
                        selectedRating = 4.0;
                        sortBy = null;
                      });
                    },
                    child: const Text("Reset"),
                  ),
                ),
                16.vBox,
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context, {
                        'category': selectedCategory,
                        'priceRange': priceRange,
                        'brand': selectedBrand,
                        'rating': selectedRating,
                        'sortBy': sortBy,
                      });
                    },
                    child: const Text("Apply"),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
