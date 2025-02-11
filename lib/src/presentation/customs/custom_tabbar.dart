
// ignore: must_be_immutable
import 'package:flutter/material.dart';
import 'package:quickdeal/src/core/utils/ui_utils/extensions.dart';

import '../../core/utils/ui_utils/constants/colors.dart';


// ignore: must_be_immutable
class CustomTabbar extends StatefulWidget {
  CustomTabbar(
      {super.key,
      required this.noOfTab,
      required this.tabs,
      required this.selectedTab,
      this.listLengths});

  final int noOfTab;
  final List<String> tabs;
  int selectedTab;
  final List<int>? listLengths;

  @override
  State<CustomTabbar> createState() => _CustomTabbarState();
}

class _CustomTabbarState extends State<CustomTabbar> {
  @override
  Widget build(BuildContext context) {
    var dark = context.isDarkMode;
    return Container(
      margin: EdgeInsets.all(12.w),
      decoration: BoxDecoration(
          color: dark ? CColors.darkContainer : Colors.white,
          borderRadius: BorderRadius.circular(44.h)),
      padding: EdgeInsets.all(0.w),
      child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: List.generate(
            widget.tabs.length,
            (index) {
              return GestureDetector(
                onTap: () {
                  widget.selectedTab = index;
                  setState(() {});
                },
                child: Container(
                  decoration: widget.selectedTab == index
                      ? BoxDecoration(
                          borderRadius: BorderRadius.circular(44.h),
                          color: dark ? CColors.darkContainer : CColors.primary)
                      : const BoxDecoration(),
                  padding: const EdgeInsets.all(12),
                  child: Row(children: [
                    Text(widget.tabs[index],
                        style: Theme.of(context).textTheme.titleSmall!.copyWith(
                            color: widget.selectedTab == index
                                ? Colors.white
                                : dark
                                    ? CColors.darkGrey
                                    : Colors.black)),
                    6.0.pw,
                    widget.listLengths == null
                        ? const SizedBox()
                        : CircleAvatar(
                            backgroundColor: widget.selectedTab == index
                                ? Colors.red.shade500
                                : dark
                                    ? CColors.darkContainer
                                    : Colors.grey.shade300,
                            child: Container(
                                padding: const EdgeInsets.all(6.0),
                                child: Text(
                                  widget.listLengths![index].toString(),
                                  style: const TextStyle(color: Colors.white),
                                )),
                          )
                  ]),
                ),
              );
            },
          )),
    );
  }
}
