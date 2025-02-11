import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/utils/ui_utils/constants/assets.dart';
import 'states/dashboard_state.dart';
import 'subscreens/attendance/attendance_screen.dart';
import 'subscreens/expense/expense_screen.dart';
import 'subscreens/home/home_screen.dart';
import 'subscreens/leave/leave_screen.dart';

class Dashboard extends ConsumerStatefulWidget {
  const Dashboard({super.key});

  @override
  ConsumerState<Dashboard> createState() => _NavigationMenuState();
}

class _NavigationMenuState extends ConsumerState<Dashboard> {
  bool cardLoading = true;

  final PageController _pageController = PageController();

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {});
    super.initState();
  }

  final screens = [
    const HomeScreen(),
    const AttendanceScreen(),
    const ExpenseScreen(),
    const LeaveScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    var selectedIndex = ref.watch(intBottomNavBarIndex);

    return WillPopScope(
      onWillPop: () async {
        final shouldClose = await showCupertinoDialog(
          context: context,
          builder: (context) => CupertinoAlertDialog(
            title: const Text('Exit App'),
            content: const Text('Are you sure you want to close the app?'),
            actions: [
              CupertinoDialogAction(
                onPressed: () => Navigator.of(context).pop(false),
                child: const Text('No'),
              ),
              CupertinoDialogAction(
                isDestructiveAction: true,
                onPressed: () => Navigator.of(context).pop(true),
                child: const Text('Yes'),
              ),
            ],
          ),
        );
        return shouldClose ?? false;
      },
      child: Scaffold(
        bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          backgroundColor: Colors.black,
          selectedItemColor: Colors.white,
          unselectedItemColor: Colors.grey,
          currentIndex: selectedIndex,
          onTap: (s) {
            ref.read(intBottomNavBarIndex.notifier).state = s;
            _pageController.animateToPage(s,
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeInOut);
          },
          items: [
            _buildNavItem(
                selectedIcon: AssetsConsts.filledNavBar1,
                unselectedIcon: AssetsConsts.outlinedNavBar1,
                index: 0),
            _buildNavItem(
                selectedIcon: AssetsConsts.filledNavBar2,
                unselectedIcon: AssetsConsts.outlinedNavBar2,
                index: 1),
            _buildNavItem(
                selectedIcon: AssetsConsts.filledNavBar3,
                unselectedIcon: AssetsConsts.outlinedNavBar3,
                index: 2),
            _buildNavItem(
                selectedIcon: AssetsConsts.filledNavBar4,
                unselectedIcon: AssetsConsts.outlinedNavBar4,
                index: 3),
          ],
        ),
        body: AnimatedSwitcher(
          duration: const Duration(milliseconds: 300),
          child: screens[selectedIndex],
        ),
      ),
    );
  }

  BottomNavigationBarItem _buildNavItem(
      {required String selectedIcon,
      required String unselectedIcon,
      required int index}) {
    return BottomNavigationBarItem(
      icon: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          AnimatedSwitcher(
            duration: const Duration(milliseconds: 200),
            child: Image.asset(
              ref.read(intBottomNavBarIndex) == index
                  ? selectedIcon
                  : unselectedIcon,
              key: ValueKey<int>(index),
              height: 24,
            ),
          ),
          if (ref.read(intBottomNavBarIndex) == index)
            Container(
              margin: const EdgeInsets.only(top: 4),
              width: 13,
              height: 2,
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(12)),
            ),
          // Just to add space
          if (ref.read(intBottomNavBarIndex) != index)
            Container(
              margin: const EdgeInsets.only(top: 4),
              width: 13,
              height: 2,
            ),
        ],
      ),
      label: '',
    );
  }
}