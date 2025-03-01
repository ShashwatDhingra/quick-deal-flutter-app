import 'package:flutter/material.dart';
import 'package:quickdeal/src/core/utils/ui_utils/constants/colors.dart';

class CustomSelectField extends StatefulWidget {
  final List<String> options;
  final dynamic selectedValue;
  final String? labelText;
  final void Function(dynamic) onChanged;
  final String? Function(dynamic)? validator;
  final BoxDecoration? decoration;
  final bool isMultiSelect;

  const CustomSelectField({
    super.key,
    required this.options,
    required this.selectedValue,
    required this.onChanged,
    this.labelText,
    this.validator,
    this.decoration,
    this.isMultiSelect = true,
  });

  @override
  _CustomSelectFieldState createState() => _CustomSelectFieldState();
}

class _CustomSelectFieldState extends State<CustomSelectField> {
  late dynamic selectedItems;

  @override
  void initState() {
    super.initState();
    selectedItems = widget.isMultiSelect
        ? List<String>.from(widget.selectedValue ?? [])
        : widget.selectedValue ?? '';
  }

  void _showSelectionDialog(FormFieldState<dynamic> state) {
    dynamic tempSelected =
        widget.isMultiSelect ? List<String>.from(selectedItems) : selectedItems;

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
                  const Text(
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
                        bool isSelected = widget.isMultiSelect
                            ? tempSelected.contains(option)
                            : tempSelected == option;
                        return ListTile(
                          title: Text(option),
                          leading: widget.isMultiSelect
                              ? Checkbox(
                                  value: isSelected,
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
                                )
                              : Radio<String>(
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
                              if (widget.isMultiSelect) {
                                isSelected
                                    ? tempSelected.remove(option)
                                    : tempSelected.add(option);
                              } else {
                                tempSelected = option;
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
                            state.didChange(selectedItems);
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
    return FormField<dynamic>(
      initialValue: selectedItems,
      validator: widget.validator,
      builder: (state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            GestureDetector(
              onTap: () => _showSelectionDialog(state),
              child: InputDecorator(
                decoration: InputDecoration(
                  labelText: widget.labelText,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12.0),
                    borderSide: BorderSide(
                        color: state.hasError ? Colors.red : CColors.primary,
                        width: 1.5),
                  ),
                  errorText: state.errorText,
                  suffixIcon:
                      const Icon(Icons.arrow_drop_down, color: Colors.grey),
                ),
                child: selectedItems == '' ||
                        (selectedItems is List && selectedItems.isEmpty)
                    ? Text(widget.labelText ?? 'Tap to Select',
                        style: const TextStyle(color: Colors.grey))
                    : widget.isMultiSelect
                        ? Wrap(
                            spacing: 6,
                            runSpacing: 6,
                            children: (selectedItems as List<String>)
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
                          )
                        : Text(selectedItems,
                            style: const TextStyle(color: Colors.black)),
              ),
            ),
            if (state.hasError)
              Padding(
                padding: const EdgeInsets.only(top: 5, left: 10),
                child: Text(
                  state.errorText!,
                  style: const TextStyle(color: Colors.red, fontSize: 12),
                ),
              ),
          ],
        );
      },
    );
  }
}
