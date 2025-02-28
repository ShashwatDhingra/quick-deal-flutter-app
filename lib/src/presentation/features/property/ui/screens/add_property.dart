import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:quickdeal/src/core/utils/ui_utils/constants/colors.dart';
import 'package:quickdeal/src/presentation/features/dashboard/subscreens/profile/profile.dart';
import 'package:quickdeal/src/presentation/features/property/states/add_property_state.dart';
import 'package:quickdeal/src/presentation/features/property/states/first_page_state.dart';

class AddPropertyScreen extends ConsumerStatefulWidget {
  const AddPropertyScreen({super.key});

  @override
  ConsumerState<AddPropertyScreen> createState() => _AddPropertyScreenState();
}

class _AddPropertyScreenState extends ConsumerState<AddPropertyScreen> {
  @override
  Widget build(BuildContext context) {
    final addPropertyState = ref.watch(addPropertyStateProvider);
    final addPropertyNotifier = ref.read(addPropertyStateProvider.notifier);
    return PopScope(
      onPopInvoked: (didPop) async {
        if (didPop) return;

        bool? exitConfirmed = await showDialog<bool>(
          context: context,
          builder: (context) {
            return CupertinoAlertDialog(
              title: const Text("Confirm Exit"),
              content: const Text("Are you sure you want to exit?"),
              actions: [
                TextButton(
                  onPressed: () => Navigator.of(context).pop(false), // Cancel
                  child: const Text("No"),
                ),
                TextButton(
                  onPressed: () => Navigator.of(context).pop(true), // Exit
                  child: const Text("Yes"),
                ),
              ],
            );
          },
        );

        if (exitConfirmed == true) {
          addPropertyNotifier.clearState();
          Navigator.of(context).pop(); // Close the screen
        }
      },
      canPop: false,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Add Property'),
          elevation: 2,
          // shadowColor: Colors.grey.withOpacity(0.7),
          backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
        ),
        body: Column(
          children: [
            Expanded(
              child: PageView(
                controller: addPropertyNotifier.pageController,
                onPageChanged: (index) {
                  addPropertyNotifier.changePage(index);
                },
                children: addPropertyState.pages,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Expanded(
                    child: IconButton(
                      icon: Icon(Icons.arrow_back_ios_rounded, size: 30),
                      onPressed: addPropertyNotifier.canPreviousPage()
                          ? addPropertyNotifier.goToPrevioudPage
                          : null,
                    ),
                  ),
                  Expanded(
                    child: Center(
                      child: Stack(
                        children: [
                          // Background Bar
                          Container(
                            height: 4,
                            width: 100,
                            decoration: BoxDecoration(
                              color: Colors.grey[300],
                              borderRadius: BorderRadius.circular(4),
                            ),
                          ),
                          // Animated Progress Indicator
                          AnimatedContainer(
                            duration: Duration(milliseconds: 300),
                            height: 4,
                            width: (100 / addPropertyState.pages.length) *
                                (addPropertyState.currentPage +
                                    1), // Dynamic width
                            decoration: BoxDecoration(
                              color: CColors.primary, // Blue color
                              borderRadius: BorderRadius.circular(4),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    child: IconButton(
                        icon: (addPropertyState.currentPage) ==
                                addPropertyState.pages.length - 1
                            ? const Icon(
                                Icons.done,
                                size: 30,
                                color: CColors.primary,
                              )
                            : const Icon(Icons.arrow_forward_ios_rounded,
                                size: 30),
                        onPressed: addPropertyNotifier.goToNextPage),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
