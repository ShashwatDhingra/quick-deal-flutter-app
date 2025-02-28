import 'package:flutter/material.dart';
import 'package:quickdeal/src/core/utils/ui_utils/extensions.dart';

import '../../../../../../core/utils/ui_utils/constants/colors.dart';

class CustomSearchBar extends StatelessWidget {
  final Function(String) onChanged;
  final Function onBackPressed;

  const CustomSearchBar({
    super.key,
    required this.onChanged,
    required this.onBackPressed,
  });

  @override
  Widget build(BuildContext context) {
    //var isDark = context.isDarkMode;
    return TextFormField(
      onChanged: onChanged,
      decoration: InputDecoration(
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(100),
            borderSide: BorderSide.none),
        fillColor: Colors.grey.withOpacity(0.10),
        filled: true,
        suffixIcon: SizedBox(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              IconButton(
                  onPressed: () {}, icon: const Icon(Icons.refresh_sharp)),
              IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.crop_rotate_outlined)),
              IconButton(onPressed: () {}, icon: const Icon(Icons.more_vert)),
            ],
          ),
        ),
        prefixIcon: SizedBox(
          width: 40,
          child: Row(
            children: [
              IconButton(
                  onPressed: () => onBackPressed(),
                  icon: const Icon(
                    Icons.arrow_back_sharp,
                    color: CColors.primary,
                  )),
            ],
          ),
        ),
        hintText: "Search",
        hintStyle: TextStyle(fontSize: 15.sp, color: Colors.grey),
      ),
    );
  }
}
