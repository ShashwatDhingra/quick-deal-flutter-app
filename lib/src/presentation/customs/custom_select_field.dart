import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:quickdeal/src/core/utils/ui_utils/constants/colors.dart';

class CustomSelectField extends StatefulWidget {
  final List<String> options;
  final List<String> selectedValues;
  final String? labelText;
  final void Function(List<String>) onChanged;
  final String? Function(List<String>?)? validator;
  final BoxDecoration? decoration;

  const CustomSelectField({
    super.key,
    required this.options,
    required this.selectedValues,
    required this.onChanged,
    this.labelText,
    this.validator,
    this.decoration,
  });

  @override
  _CustomSelectFieldState createState() => _CustomSelectFieldState();
}

class _CustomSelectFieldState extends State<CustomSelectField> {
  late List<String> selectedItems;

  @override
  void initState() {
    super.initState();
    selectedItems = List.from(widget.selectedValues);
  }

  void _showIosSelectionSheet(FormFieldState<List<String>> state) {
    List<String> tempSelected = List.from(selectedItems);

    showCupertinoModalPopup(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setModalState) {
            return CupertinoActionSheet(
              title: const Text("Select Options"),
              message: Column(
                children: widget.options.map((option) {
                  return CupertinoListTile(
                    title: Text(option),
                    leading: CupertinoCheckbox(
                      value: tempSelected.contains(option),
                      activeColor: CColors.primary,
                      onChanged: (bool? selected) {
                        setModalState(() {
                          if (selected == true) {
                            tempSelected.add(option);
                          } else {
                            tempSelected.remove(option);
                          }
                        });
                      },
                    ),
                  );
                }).toList(),
              ),
              actions: [
                CupertinoActionSheetAction(
                  onPressed: () {
                    setState(() {
                      selectedItems = tempSelected;
                      widget.onChanged(selectedItems);
                    });
                    state.didChange(selectedItems); // Trigger validation
                    Navigator.pop(context);
                  },
                  child: const Text("OK"),
                ),
              ],
              cancelButton: CupertinoActionSheetAction(
                isDestructiveAction: true,
                onPressed: () => Navigator.pop(context),
                child: const Text("Cancel"),
              ),
            );
          },
        );
      },
    );
  }

  void _showAndroidSelectionDialog(FormFieldState<List<String>> state) {
    List<String> tempSelected = List.from(selectedItems);

    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return Container(
              padding: const EdgeInsets.all(16),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    "Select Options",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: CColors.primary,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Expanded(
                    child: ListView(
                      children: widget.options.map((option) {
                        return ListTile(
                          title: Text(option),
                          trailing: tempSelected.contains(option)
                              ? Icon(Icons.check_circle, color: CColors.primary)
                              : const Icon(Icons.circle_outlined,
                                  color: Colors.grey),
                          onTap: () {
                            setState(() {
                              if (tempSelected.contains(option)) {
                                tempSelected.remove(option);
                              } else {
                                tempSelected.add(option);
                              }
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
                              selectedItems = tempSelected;
                              widget.onChanged(selectedItems);
                            });
                            state
                                .didChange(selectedItems); // Trigger validation
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
    return FormField<List<String>>(
      initialValue: selectedItems,
      validator: widget.validator,
      builder: (state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            GestureDetector(
              onTap: () => Platform.isIOS
                  ? _showIosSelectionSheet(state)
                  : _showAndroidSelectionDialog(state),
              child: Platform.isIOS
                  ? Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 14),
                      decoration: widget.decoration ??
                          BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(
                                color: CupertinoColors.systemGrey, width: 1.5),
                          ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Text(
                              selectedItems.isEmpty
                                  ? widget.labelText ?? 'Tap to Select'
                                  : selectedItems.join(', '),
                              style: const TextStyle(fontSize: 16),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          const Icon(
                            CupertinoIcons.chevron_down,
                            color: CupertinoColors.systemGrey,
                          ),
                        ],
                      ),
                    )
                  : InputDecorator(
                      decoration: InputDecoration(
                        labelText: widget.labelText,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12.0),
                          borderSide: BorderSide(
                              color:
                                  state.hasError ? Colors.red : CColors.primary,
                              width: 1.5),
                        ),
                        errorText: state.errorText, // Show error message
                        suffixIcon: const Icon(Icons.arrow_drop_down,
                            color: Colors.grey),
                      ),
                      child: Wrap(
                        spacing: 6,
                        runSpacing: 6,
                        children: selectedItems.isEmpty
                            ? [
                                Text(widget.labelText ?? 'Tap to Select',
                                    style: TextStyle(color: Colors.grey))
                              ]
                            : selectedItems
                                .map((e) => Chip(
                                      label: Text(e),
                                      backgroundColor:
                                          CColors.primary.withOpacity(0.2),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                      deleteIcon:
                                          const Icon(Icons.close, size: 18),
                                      onDeleted: () {
                                        setState(() {
                                          selectedItems.remove(e);
                                          widget.onChanged(selectedItems);
                                          state.didChange(selectedItems);
                                        });
                                      },
                                    ))
                                .toList(),
                      ),
                    ),
            ),
            if (state.hasError)
              Padding(
                padding: const EdgeInsets.only(top: 5, left: 10),
                child: Text(
                  state.errorText!,
                  style: TextStyle(color: Colors.red, fontSize: 12),
                ),
              ),
          ],
        );
      },
    );
  }
}
