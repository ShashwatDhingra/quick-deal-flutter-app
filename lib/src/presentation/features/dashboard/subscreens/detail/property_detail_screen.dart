import 'package:cached_network_image/cached_network_image.dart';
import 'package:quickdeal/src/core/router/routes.dart';
import 'package:quickdeal/src/data/models/property_model.dart';
import 'package:quickdeal/src/presentation/customs/see_all.dart';
import 'package:quickdeal/src/presentation/features/dashboard/subscreens/profile/profile.dart';
import 'package:quickdeal/src/presentation/features/dashboard/subscreens/search/widgets/filter_button.dart';

import '../../../../customs/custom_icon_button.dart';
import '../../../../customs/custom_zoom_widget.dart';

// ignore: must_be_immutable
class PropetyDetailScreen extends StatefulWidget {
  PropetyDetailScreen({super.key, required this.property});

  PropertyModel property;

  @override
  State<PropetyDetailScreen> createState() => _PropetyDetailScreenState();
}

class _PropetyDetailScreenState extends State<PropetyDetailScreen> {
  List<Map<String, dynamic>> propertyFeatures = [
    {"name": "WiFi", "icon": Icons.wifi},
    {"name": "Gym", "icon": Icons.fitness_center},
    {"name": "TV", "icon": Icons.tv},
    {"name": "Swimming Pool", "icon": Icons.pool},
    {"name": "Air Conditioning", "icon": Icons.ac_unit},
    {"name": "Parking", "icon": Icons.local_parking},
    {"name": "Security", "icon": Icons.security},
    {"name": "Elevator", "icon": Icons.elevator},
    {"name": "Garden", "icon": Icons.park},
    {"name": "Balcony", "icon": Icons.balcony},
    {"name": "Power Backup", "icon": Icons.power},
    {"name": "Fire Safety", "icon": Icons.fire_extinguisher},
    {"name": "CCTV Surveillance", "icon": Icons.videocam},
  ];

  List<Map<String, dynamic>> propertyDetails = [
    {
      "title": "Property ID",
      "value": "PKYLL1628389",
    },
    {
      "title": "Width",
      "value": "50 ft",
    },
    {
      "title": "Length",
      "value": "100 ft",
    },
    {
      "title": "Year Built",
      "value": "2015",
    },
    {
      "title": "Floors",
      "value": "2",
    },
  ];

  List<Map<String, dynamic>> propertyFilters = [
    {"icon": Icons.bed, "text": "4 Bedrooms"},
    {"icon": Icons.bathtub, "text": "2 Bathrooms"},
    {"icon": Icons.local_parking, "text": "1 Parking"},
    {"icon": Icons.kitchen, "text": "Modular Kitchen"},
    {"icon": Icons.home, "text": "Furnished"},
  ];

  final ValueNotifier<bool> isExpanded = ValueNotifier(false);

  @override
  Widget build(BuildContext context) {
    var isDark = context.isDarkMode;

    return Scaffold(
      // bottomNavigationBar: Padding(
      //   padding: const EdgeInsets.all(8.0),
      //   child: Row(
      //     children: [
      //       Expanded(
      //           flex: 9,
      //           child: CustomElevatedButton(
      //             onPress: () {},
      //             text: "Email",
      //           )),
      //       const Expanded(child: SizedBox()),
      //       Expanded(
      //           flex: 9,
      //           child: CustomElevatedButton(
      //             buttonColor: CColors.success,
      //             onPress: () {},
      //             text: "Phone",
      //           ))
      //     ],
      //   ),
      // ),

      // appBar: AppBar(
      //   title: const Text('Detail Screen'),
      //   actions: [
      //     TextButton(
      //         onPressed: () {
      //           context.pushNamed(Routes.createFollowupFormScreen,
      //               arguments: widget.property.id);
      //         },
      //         child: const Text('FollowUp '))
      //   ],
      // ),
      body: Column(
        children: [
          // Stack
          Expanded(
            flex: 4,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: GestureDetector(
                onTap: () {
                 
                  context.push(ZoomImg(
                    itemList: widget.property.images ?? [],
                  ));
                },
                child: CachedNetworkImage(
                  width: double.infinity,
                  imageUrl: (widget.property.images != null &&
                          widget.property.images!.isNotEmpty)
                      ? widget.property.images![0]
                      : 'https://media.istockphoto.com/id/1409329028/vector/no-picture-available-placeholder-thumbnail-icon-illustration-design.jpg?s=612x612&w=0&k=20&c=_zOuJu755g2eEUioiOUdz_mHKJQJn-tDgIAhQzyeKUQ=',
                  fit: BoxFit.cover,
                  placeholder: (context, url) =>
                      Container(color: Colors.grey[200]),
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                ),
              ),
            ),
          ),
          Expanded(
              flex: 9,
              child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Row(
                          children: [
                            Expanded(child: SizedBox()),
                            Expanded(child: SizedBox())
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              widget.property.title,
                              style: TextStyle(
                                  fontSize: 15.sp, fontWeight: FontWeight.bold),
                            ),
                            TextButton(
                                onPressed: () {
                                  context.pushNamed(Routes.followupScreen,
                                      arguments: widget.property.id);
                                },
                                child: const Text('FollowUp '))
                          ],
                        ),
                        10.hBox,
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  color: Colors.grey.withOpacity(0.15)),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                    'For - ${widget.property.propertyType ?? 'Sale/Rent'}'),
                              ),
                            ),
                            Text(
                              'Rs. ${widget.property.price.toString()}',
                              style: TextStyle(
                                  fontSize: 20.sp, fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                        10.hBox,

                        SizedBox(
                          height: 50.h,
                          width: double.infinity,
                          child: ListView.builder(
                            shrinkWrap: true,
                            scrollDirection: Axis.horizontal,
                            itemCount: propertyFilters.length,
                            itemBuilder: (context, index) {
                              return Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: buildFilterButton(
                                  icon: propertyFilters[index]["icon"],
                                  text: propertyFilters[index]["text"],
                                  iconColor: CColors.primary,
                                ),
                              );
                            },
                          ),
                        ),

                        20.hBox,
                        // Deail List
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Details",
                              style: TextStyle(fontSize: 15.sp),
                            ),
                            seeAll(
                              text: "More Details",
                              onPressed: () {},
                            )
                          ],
                        ),
                        20.hBox,
                        Container(
                          height: 200.h,
                          decoration: BoxDecoration(
                            color: isDark
                                ? CColors.darkContainer
                                : const Color(0xfff5f5f5),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: ListView.separated(
                            padding: const EdgeInsets.all(0),
                            separatorBuilder: (context, index) {
                              return Divider(
                                color: isDark
                                    ? CColors.textSecondary
                                    : Colors.black.withOpacity(0.2),
                              );
                            },
                            shrinkWrap: true,
                            scrollDirection: Axis.vertical,
                            itemCount: propertyDetails.length,
                            itemBuilder: (context, index) {
                              return ListTile(
                                title: Text(
                                  propertyDetails[index]["title"],
                                  style: TextStyle(
                                    color: isDark
                                        ? CColors.textWhite
                                        : Colors.black.withOpacity(0.4),
                                  ),
                                ),
                                trailing: Text(
                                  propertyDetails[index]["value"],
                                  style: TextStyle(
                                    color: isDark
                                        ? CColors.textWhite
                                        : Colors.black,
                                  ),
                                ),
                              );
                            },
                          ),
                        ),

                        20.hBox,
                        // Deail List
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Features",
                              style: TextStyle(fontSize: 15.sp),
                            ),
                            seeAll(
                              text: "Show More",
                              onPressed: () {},
                            )
                          ],
                        ),
                        20.hBox,
                        SizedBox(
                          height: 80.h,
                          child: ListView.separated(
                            scrollDirection: Axis.horizontal,
                            separatorBuilder: (context, index) =>
                                SizedBox(width: 15.w),
                            itemCount: propertyFeatures.length,
                            itemBuilder: (context, index) {
                              return Column(
                                children: [
                                  CustomIconButton(
                                    width: 60.w,
                                    height: 60.h,
                                    assetSt: "",
                                    defaultIcon: propertyFeatures[index]
                                        ['icon'],
                                  ),
                                  Text(propertyFeatures[index]['name']),
                                ],
                              );
                            },
                          ),
                        ),

                        20.hBox,
                        // Description

                        ValueListenableBuilder<bool>(
                          valueListenable: isExpanded,
                          builder: (context, value, child) {
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text("Description",
                                        style: TextStyle(fontSize: 15.sp)),
                                    seeAll(
                                      text: value ? "Read less" : "Read more",
                                      onPressed: () =>
                                          isExpanded.value = !value,
                                    )
                                  ],
                                ),
                                10.hBox,
                                Text(
                                  value
                                      ? "It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout..."
                                      : "It is a long established fact that a reader will be distracted...",
                                ),
                              ],
                            );
                          },
                        ),

                        20.hBox,
                        // Address
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Address",
                              style: TextStyle(fontSize: 15.sp),
                            ),
                            seeAll(
                              text: "Open Map",
                              onPressed: () {},
                            )
                          ],
                        ),
                        10.hBox,
                        const Text(
                            "Pillor No  69, Sector 31 haryana faridabad 121003 ")
                      ],
                    ),
                  ))),
        ],
      ),
    );
  }
}
