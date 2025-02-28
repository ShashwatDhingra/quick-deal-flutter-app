import 'package:flutter/material.dart';
import 'package:quickdeal/src/core/utils/ui_utils/extensions.dart';
import 'package:quickdeal/src/presentation/features/dashboard/subscreens/home/home_screen.dart';
import '../../../../../core/router/routes.dart';
import 'widgets/custom_searchbar.dart';
import 'widgets/filter_button.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Expanded(
                flex: 3,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      CustomSearchBar(
                        onChanged: (value) {},
                        onBackPressed: () {},
                      ),
                      10.ph,
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: List.generate(
                            4,
                            (index) => buildFilterButton(
                                icon: Icons.filter_alt_outlined,
                                text: index == 0 ? null : "All")),
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                flex: 17,
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
                            Text("29 Results",
                                style: TextStyle(fontSize: 20.h)),
                            Text("Showing Newest Results",
                                style: TextStyle(fontSize: 10.h)),
                            10.ph,
                            ListView.separated(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              separatorBuilder: (_, __) =>
                                  SizedBox(height: 12.h),
                              itemCount: 15,
                              itemBuilder: (_, index) => SinglePropertyCard(
                                onTap: () {
                                  Navigator.pushNamed(
                                      context, Routes.propertyDetailScreen);
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
      ),
    );
  }
}
