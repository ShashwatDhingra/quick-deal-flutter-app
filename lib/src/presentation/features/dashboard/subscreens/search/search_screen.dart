import 'package:flutter/material.dart';
import 'package:quickdeal/src/core/utils/ui_utils/extensions.dart';
import 'package:quickdeal/src/presentation/features/dashboard/subscreens/home/home_screen.dart';
import '../../../../../core/router/routes.dart';
import '../../../../customs/custom_icon_button.dart';
import '../../../../customs/custom_single_property_card.dart';
import '../../../followup/widgets/lead_filter.dart';
import 'widgets/custom_searchBar.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              // Search Bar
              Expanded(
                flex: 2,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      CustomSearchBar(
                        onChanged: (value) {},
                        onBackPressed: () {
                          context.pop();
                        },
                      ),
                      15.hBox,
                    ],
                  ),
                ),
              ),

              //List of Items widget
              Expanded(
                flex: 19,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    /// Filter Row
                    Expanded(
                        flex: 1,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SingleChildScrollView(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("29 Results",
                                      style: TextStyle(fontSize: 20.h)),
                                  Text("Showing Newest Results",
                                      style: TextStyle(fontSize: 10.h)),
                                ],
                              ),
                            ),
                            CustomIconButton(
                              width: 40.w,
                              height: 40.h,
                              assetSt: "",
                              onTap: () {
                                showModalBottomSheet(
                                  context: context,
                                  isScrollControlled: true,
                                  shape: const RoundedRectangleBorder(
                                    borderRadius: BorderRadius.vertical(
                                      top: Radius.circular(20),
                                    ),
                                  ),
                                  builder: (context) =>
                                      const FilterBottomSheet(),
                                );
                              },
                              defaultIcon: Icons.filter_alt_outlined,
                            ),
                          ],
                        )),

                    ///List of item
                    Expanded(
                      flex: 11,
                      child: LayoutBuilder(
                        builder: (context, constraints) {
                          return SingleChildScrollView(
                            child: ConstrainedBox(
                              constraints: BoxConstraints(
                                minHeight: constraints.maxHeight,
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  // 10.vBox,
                                  ListView.separated(
                                    shrinkWrap: true,
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    separatorBuilder: (_, __) =>
                                        SizedBox(height: 12.h),
                                    itemCount: 15,
                                    itemBuilder: (_, index) =>
                                        SinglePropertyCard(
                                      onTap: () {
                                        Navigator.pushNamed(context,
                                            Routes.propertyDetailScreen);
                                      },
                                      imageUrl:
                                          "https://i.pinimg.com/736x/b2/9e/97/b29e9776d0c4448aab9d4df1a0962a43.jpg",
                                      title: "Luxury Apartment",
                                      type: "Rent",
                                      location: "456 Elm St, Town",
                                      bedrooms: 3,
                                      bathrooms: 2,
                                      area: 150,
                                      price: "3000",
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
