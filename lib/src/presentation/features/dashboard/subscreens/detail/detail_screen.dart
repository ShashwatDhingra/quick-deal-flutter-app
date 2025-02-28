import 'package:quickdeal/src/presentation/customs/see_all.dart';
import 'package:quickdeal/src/presentation/features/dashboard/subscreens/profile/profile.dart';
import 'package:quickdeal/src/presentation/features/dashboard/subscreens/search/widgets/filter_button.dart';

import '../../../../customs/custom_icon_button.dart';

class PropetyDetailScreen extends StatefulWidget {
  const PropetyDetailScreen({super.key});

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
      body: Column(
        children: [
          Expanded(
            flex: 4,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Hero(
                tag: 'img1',
                child: Image.network(
                    width: double.infinity,
                    "https://i.pinimg.com/736x/b2/9e/97/b29e9776d0c4448aab9d4df1a0962a43.jpg",
                    fit: BoxFit.cover),
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
                    Text(
                      "OSM villa",
                      style: TextStyle(
                          fontSize: 15.sp, fontWeight: FontWeight.bold),
                    ),
                    10.hBox,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          child: const Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text("FOR Sale"),
                          ),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              color: Colors.grey.withOpacity(0.15)),
                        ),
                        Text(
                          "57000",
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
                                color:
                                    isDark ? CColors.textWhite : Colors.black,
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
                                defaultIcon: propertyFeatures[index]['icon'],
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
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text("Description",
                                    style: TextStyle(fontSize: 15.sp)),
                                seeAll(
                                  text: value ? "Read less" : "Read more",
                                  onPressed: () => isExpanded.value = !value,
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
              ),
            ),
          ),
        ],
      ),
    );
  }
}
