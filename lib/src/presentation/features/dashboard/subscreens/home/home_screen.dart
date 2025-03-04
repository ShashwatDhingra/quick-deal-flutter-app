import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:quickdeal/src/core/utils/ui_utils/constants/assets.dart';
import 'package:quickdeal/src/core/utils/ui_utils/extensions.dart';
import 'package:quickdeal/src/presentation/customs/custom_icon_button.dart';
import 'package:quickdeal/src/presentation/features/dashboard/subscreens/home/widgets/body_tile1.dart';
import 'package:quickdeal/src/presentation/features/dashboard/subscreens/home/widgets/body_tile3.dart';

import '../../../../../core/router/routes.dart';
import '../../../../../core/utils/ui_utils/constants/colors.dart';
import '../../../../../core/utils/ui_utils/helpers/helper_functions.dart';
import '../../../../customs/drawer.dart';
import '../../../../global/user_provider.dart';
import 'widgets/body_tile2.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  bool isScrolled = false;
  late ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _scrollController.addListener(() {
      double offset = _scrollController.offset;

      setState(() {
        if (offset > 50) {
          isScrolled = true;
        } else {
          isScrolled = false;
        }
      });
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    var isDark = context.isDarkMode;
    var user = ref.read(userProvider);

    return Scaffold(
      key: _scaffoldKey,
      drawer: const CustomDrawer(),
      body: Column(
        children: [
          /// **Animated AppBar**
          AnimatedContainer(
            duration: const Duration(milliseconds: 300), // Smooth animation
            padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
            color: isDark ? CColors.black : Colors.white,
            child: Row(
              children: [
                /// Menu Icon
                Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: IconButton(
                    icon: Icon(
                      Icons.menu,
                      size: 24.sp,
                      color: isDark ? CColors.white : Colors.black,
                    ),
                    onPressed: () {
                      _scaffoldKey.currentState?.openDrawer();
                    },
                  ),
                ),

                /// Location Widget (Fade out on Scroll)
                isScrolled
                    ? const SizedBox()
                    : Expanded(
                        flex: 3,
                        child: AnimatedOpacity(
                          duration: const Duration(milliseconds: 300),
                          opacity: 1,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '${HelperFunctions().getGreetingMessage()} ${user!.name} 👋',
                                style: TextStyle(
                                  overflow: TextOverflow.ellipsis,
                                  color: isDark ? Colors.white : Colors.black,
                                  fontSize: 20.sp,
                                ),
                              ),
                              const Text("Organized, Optimized, Sold!")
                            ],
                          ),
                        ),
                      ),

                /// Search Field (Fade in on Scroll)
                Expanded(
                  child: AnimatedOpacity(
                    duration: const Duration(milliseconds: 300),
                    opacity: isScrolled ? 1.0 : 0.0,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 4.0),
                      child: InkWell(
                        onTap: () {
                          Navigator.pushNamed(context, Routes.searchScreen);
                        },
                        child: SizedBox(
                          height: isScrolled ? 31.h : 80.h,
                          child: TextFormField(
                            onChanged: (value) {},
                            decoration: InputDecoration(
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(100),
                                    borderSide: BorderSide.none),
                                fillColor: Colors.grey.withOpacity(0.10),
                                filled: true,
                                suffixIcon: GestureDetector(
                                    onTap: () {},
                                    child: const Icon(Icons.filter_list)),
                                prefixIcon: const Icon(Icons.search),
                                hintText: "Search ",
                                hintStyle: TextStyle(
                                    fontSize: isScrolled ? 12.sp : 15.sp,
                                    color: Colors.grey)),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),

                /// Notification Icon
                CustomIconButton(
                  assetSt: AssetsConsts.icNotification,
                  onTap: () {
                    context.pushNamed(Routes.notificationScreen);
                  },
                ),
                SizedBox(width: 12.w),
              ],
            ),
          ),

          /// **Search Box (Initially Below AppBar)**
          AnimatedOpacity(
            duration: const Duration(milliseconds: 300),
            opacity: isScrolled ? 0.0 : 1.0,
            child: isScrolled
                ? const SizedBox()
                : Padding(
                    padding: EdgeInsets.only(
                      left: 15.w,
                      right: 15,
                      top: 15,
                    ),
                    child: SizedBox(
                      height: isScrolled ? 35.h : 80.h,
                      child: TextFormField(
                        onChanged: (value) {},
                        decoration: InputDecoration(
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(100),
                                borderSide: BorderSide.none),
                            fillColor: Colors.grey.withOpacity(0.10),
                            filled: true,
                            suffixIcon: GestureDetector(
                                onTap: () {
                                  Navigator.pushNamed(
                                      context, Routes.searchScreen);
                                },
                                child: const Icon(Icons.filter_list)),
                            prefixIcon: const Icon(Icons.search),
                            hintText: "Search ",
                            hintStyle:
                                TextStyle(fontSize: 15.sp, color: Colors.grey)),
                      ),
                    ),
                  ),
          ),

          /// **Scrollable Content**
          Expanded(
            child: SingleChildScrollView(
              controller: _scrollController,
              child: Column(
                children: [
                  BodyTile1(),
                  const BodyTile2(),
                  const BodyTile3(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}