import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:quickdeal/src/core/utils/ui_utils/constants/colors.dart';
import 'package:quickdeal/src/core/utils/ui_utils/extensions.dart';

class StateCityDropdown extends StatefulWidget {
  final void Function(Map<String, String>) onChanged;

  const StateCityDropdown({super.key, required this.onChanged});

  @override
  // ignore: library_private_types_in_public_api
  _StateCityDropdownState createState() => _StateCityDropdownState();
}

class _StateCityDropdownState extends State<StateCityDropdown> {
  String? selectedState;
  String? selectedCity;
  List<String> states = [];
  List<String> cities = [];

  @override
  void initState() {
    super.initState();
    fetchStates();
  }

  Future<void> fetchStates() async {
    final response = await http.get(Uri.parse('https://api.example.com/states'));
    if (response.statusCode == 200) {
      setState(() {
        states = List<String>.from(json.decode(response.body));
      });
    }
  }

  Future<void> fetchCities(String state) async {
    final response = await http.get(Uri.parse('https://api.example.com/cities?state=$state'));
    if (response.statusCode == 200) {
      setState(() {
        cities = List<String>.from(json.decode(response.body));
        selectedCity = null;
      });
    }
  }

  void _showSelectionDialog(bool isState) {
    List<String> options = isState ? states : cities;
    String? tempSelected = isState ? selectedState : selectedCity;

    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setModalState) {
            return Container(
              padding: const EdgeInsets.all(16),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    "Select ${isState ? 'State' : 'City'}",
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: CColors.primary,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Expanded(
                    child: ListView(
                      children: options.map((option) {
                        return ListTile(
                          title: Text(option),
                          leading: Radio<String>(
                            value: option,
                            groupValue: tempSelected,
                            activeColor: CColors.primary,
                            onChanged: (String? selected) {
                              setModalState(() {
                                tempSelected = selected;
                              });
                            },
                          ),
                          onTap: () {
                            setModalState(() {
                              tempSelected = option;
                            });
                          },
                        );
                      }).toList(),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 18.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        TextButton(
                          onPressed: () => Navigator.pop(context),
                          child: const Text("CANCEL"),
                        ),
                        TextButton(
                          onPressed: () {
                            setState(() {
                              if (isState) {
                                selectedState = tempSelected;
                                fetchCities(selectedState!);
                              } else {
                                selectedCity = tempSelected;
                              }
                            });
                            widget.onChanged({
                              'state': selectedState ?? '',
                              'city': selectedCity ?? ''
                            });
                            Navigator.pop(context);
                          },
                          child: const Text("OK"),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    var isDark = context.isDarkMode;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        GestureDetector(
          onTap: () => _showSelectionDialog(true),
          child: InputDecorator(
            decoration: InputDecoration(
              labelText: "Select State",
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12.0),
                borderSide: const BorderSide(color: CColors.primary, width: 1.5),
              ),
            ),
            child: Text(selectedState ?? "Tap to Select", style: TextStyle(color: isDark ? CColors.textWhite : Colors.black)),
          ),
        ),
        const SizedBox(height: 16),
        GestureDetector(
          onTap: () => _showSelectionDialog(false),
          child: InputDecorator(
            decoration: InputDecoration(
              labelText: "Select City",
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12.0),
                borderSide: const BorderSide(color: CColors.primary, width: 1.5),
              ),
            ),
            child: Text(selectedCity ?? "Tap to Select", style: TextStyle(color: isDark ? CColors.textWhite : Colors.black)),
          ),
        ),
      ],
    );
  }
}
