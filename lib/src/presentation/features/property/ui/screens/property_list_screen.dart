import 'package:quickdeal/src/presentation/features/dashboard/subscreens/profile/profile.dart';
import 'package:quickdeal/src/presentation/features/property/states/property_list_state.dart';
import 'package:quickdeal/src/presentation/features/property/ui/widgets/property_list_filter.dart';

import '../../../../../core/router/routes.dart';
import '../../../../customs/custom_icon_button.dart';
import '../../../../customs/custom_single_property_card.dart';

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
          title: const Text(Texts.property),
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
                            hintText: Texts.search,
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
                          enableDrag: true,
                          isDismissible: true,
                          useSafeArea: true,
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.vertical(
                              top: Radius.circular(20),
                            ),
                          ),
                          builder: (context) {
                            return const PropertyListFilter();
                          },
                        );
                      },
                      defaultIcon: Icons.filter_alt_outlined,
                    ),
                  ],
                ),
                const SizedBox(
                  height: Sizes.sm,
                ),
                if (propertyState.propertyList.isEmpty)
                  const Expanded(
                      child:
                          Center(child: Text('No Property Available'))),
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
                        if (index == propertyState.propertyList.length) {
                          return Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: ElevatedButton(
                              onPressed: () {},
                              child:
                                  // isLoading ? CircularProgressIndicator() :
                                  const Text(Texts.loadMore),
                            ),
                          );
                        }
                        return SinglePropertyCard(
                          onTap: () {
                            Navigator.pushNamed(
                                context, Routes.propertyDetailScreen,
                                arguments: propertyState.propertyList[index]);
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
