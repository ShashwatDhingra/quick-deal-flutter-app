import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:quickdeal/src/core/utils/ui_utils/extensions.dart';
import 'package:quickdeal/src/presentation/features/dashboard/subscreens/search/search_screen.dart';

import '../../../core/utils/ui_utils/constants/colors.dart';
import 'states/dashboard_state.dart';

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
    const SearchScreen(),
    const ExpenseScreen(),
    const LeaveScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    var selectedIndex = ref.watch(intBottomNavBarIndex);
    var isDark = context.isDarkMode;
    return PopScope(
      canPop: false,
      onPopInvoked: (bool didPop) async {
        if (didPop) {
          return;
        }

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

        if (shouldClose ?? false) {
          // ignore: use_build_context_synchronously
          Navigator.of(context).pop();
        }
      },
      child: Scaffold(
        bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          backgroundColor: isDark ? CColors.black : Colors.white,
          selectedItemColor: CColors.primary,
          unselectedItemColor: Colors.grey,
          currentIndex: selectedIndex,
          onTap: (s) {
            ref.read(intBottomNavBarIndex.notifier).state = s;
            _pageController
                .jumpToPage(s); // Use jumpToPage instead of animateToPage
          },
          items: [
            _buildNavItem(
                selectedIcon: CupertinoIcons.house_fill,
                unselectedIcon: CupertinoIcons.home,
                index: 0),
            _buildNavItem(
                selectedIcon: CupertinoIcons.search_circle,
                unselectedIcon: CupertinoIcons.search,
                index: 1),
            _buildNavItem(
                selectedIcon: CupertinoIcons.archivebox_fill,
                unselectedIcon: CupertinoIcons.archivebox,
                index: 2),
            _buildNavItem(
                selectedIcon: CupertinoIcons.profile_circled,
                unselectedIcon: CupertinoIcons.person_crop_circle_fill,
                index: 3),
          ],
        ),
        body: PageView(
          controller: _pageController, // Connect the PageController
          physics:
              const NeverScrollableScrollPhysics(), // Disable swiping between pages
          onPageChanged: (index) {
            ref.read(intBottomNavBarIndex.notifier).state =
                index; // Update the selected index
          },
          children: screens,
        ),
      ),
    );
  }

  BottomNavigationBarItem _buildNavItem(
      {required IconData selectedIcon,
      required IconData unselectedIcon,
      required int index}) {
    return BottomNavigationBarItem(
      icon: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          AnimatedSwitcher(
            duration: const Duration(milliseconds: 200),
            child: Icon(
              ref.read(intBottomNavBarIndex) == index
                  ? selectedIcon
                  : unselectedIcon,
              color: ref.read(intBottomNavBarIndex) == index
                  ? CColors.primary
                  : Colors.grey,
              key: ValueKey<int>(index),
              //height: 24,
            ),
          ),
          if (ref.read(intBottomNavBarIndex) == index)
            Container(
              margin: const EdgeInsets.only(top: 4),
              width: 13,
              height: 2,
              decoration: BoxDecoration(
                  color: CColors.primary,
                  borderRadius: BorderRadius.circular(12)),
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
