import 'package:quickdeal/src/presentation/features/dashboard/subscreens/profile/profile.dart';
import 'package:quickdeal/src/presentation/features/lead/states/lead_state.dart';
import 'package:quickdeal/src/presentation/features/property/states/property_list_state.dart';

import '../../../../../core/router/routes.dart';
import '../../../../customs/custom_icon_button.dart';
import '../../../../customs/custom_single_property_card.dart';
import '../../../dashboard/subscreens/home/home_screen.dart';
import '../../../lead/widgets/lead_filter.dart';

class PropertyListScreen extends ConsumerStatefulWidget {
  const PropertyListScreen({super.key});

  @override
  ConsumerState<PropertyListScreen> createState() => _PropertyScreenState();
}

class _PropertyScreenState extends ConsumerState<PropertyListScreen> {
  @override
  void initState() {
    Future.microtask(
        () => ref.read(propertyStateProvider.notifier).fetchProperties());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final propertyState = ref.watch(propertyStateProvider);
    var isDark = context.isDarkMode;

    return Scaffold(
        appBar: AppBar(
          title: const Text("Property"),
        ),
        body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: Sizes.sm),
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: SizedBox(
                        height: 45,
                        child: TextFormField(
                          decoration: const InputDecoration(
                            hintText: "Search",
                            prefixIcon: Icon(Icons.search),
                            suffixIcon: Icon(Icons.close),
                          ),
                        ),
                      ),
                    ),
                    Sizes.sm.vBox,
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
                          builder: (context) => const FilterBottomSheet(),
                        );
                      },
                      defaultIcon: Icons.filter_alt_outlined,
                    ),
                  ],
                ),
                const SizedBox(
                  height: Sizes.sm,
                ),
                Expanded(
                  child: RefreshIndicator(
                    onRefresh: () {
                      return ref
                          .read(propertyStateProvider.notifier)
                          .fetchProperties();
                    },
                    color: isDark ? CColors.textWhite : CColors.primary,
                    child: ListView.separated(
                      separatorBuilder: (context, index) {
                        return 15.hBox;
                      },
                      shrinkWrap: true,
                      itemCount: propertyState.propertyList.length,
                      itemBuilder: (context, index) {
                        if (index == propertyState.propertyList) {
                          return Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: ElevatedButton(
                              onPressed: () {},
                              child:
                                  // isLoading ? CircularProgressIndicator() :
                                  const Text('Load More'),
                            ),
                          );
                        }
                        return SinglePropertyCard(
                          onTap: () {
                            Navigator.pushNamed(
                                context, Routes.propertyDetailScreen);
                          },
                          imageUrl:
                              "https://i.pinimg.com/736x/b2/9e/97/b29e9776d0c4448aab9d4df1a0962a43.jpg",
                          title: propertyState.propertyList[index].title,
                          type:
                              propertyState.propertyList[index].propertyType ??
                                  '',
                          location:
                              propertyState.propertyList[index].area ?? '',
                          bedrooms:
                              propertyState.propertyList[index].bedrooms ?? 0,
                          bathrooms:
                              propertyState.propertyList[index].bathrooms ?? 0,
                          area: double.tryParse(
                              propertyState.propertyList[index].area ?? ''),
                          price: propertyState.propertyList[index].price
                              .toString(),
                        );
                      },
                    ),
                  ),
                )
              ],
            )));
  }
}
