import 'package:quickdeal/src/presentation/features/dashboard/subscreens/profile/profile.dart';
import 'package:quickdeal/src/presentation/features/lead/states/lead_state.dart';

import '../../../core/router/routes.dart';
import '../../customs/custom_icon_button.dart';
import 'widgets/lead_filter.dart';

class LeadScreen extends ConsumerStatefulWidget {
  const LeadScreen({super.key});

  @override
  ConsumerState<LeadScreen> createState() => _LeadScreenState();
}

class _LeadScreenState extends ConsumerState<LeadScreen> {
  @override
  void initState() {
  
    Future.microtask(() => ref.read(leadStateProvider.notifier).fetchLeads());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final leadState = ref.watch(leadStateProvider);
    var isDark = context.isDarkMode;

    return Scaffold(
        appBar: AppBar(
          title: const Text("Lead"),
          actions: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: CustomIconButton(
                width: 50.w,
                height: 50.h,
                assetSt: "",
                onTap: () {
                  context.pushNamed(Routes.createLeadFormScreen);
                },
                defaultIcon: Icons.add,
              ),
            ),
          ],
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
                          showDragHandle: true,
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
                      return ref.read(leadStateProvider.notifier).fetchLeads();
                    },
                    color: isDark ? CColors.textWhite : CColors.primary,
                    child: ListView.separated(
                      separatorBuilder: (context, index) {
                        return 15.hBox;
                      },
                      shrinkWrap: true,
                      itemCount: leadState.leadList.length,
                      itemBuilder: (context, index) {
                        // ignore: unrelated_type_equality_checks
                        if (index == leadState.leadList) {
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
                        return Container(
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: isDark
                                ? CColors.grey.withOpacity(0.1)
                                : CColors.white,
                            borderRadius: BorderRadius.circular(10.sp),
                            boxShadow: [
                              BoxShadow(
                                color: isDark
                                    ? CColors.darkerGrey.withOpacity(0.2)
                                    : CColors.grey,
                                spreadRadius: 2,
                                blurRadius: 1,
                                offset: const Offset(1, 1),
                              ),
                            ],
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 15, vertical: 15),
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "John Flax",
                                          style: TextStyle(
                                              fontSize: 18.sp,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        Text(
                                          "Project No: 1232",
                                          style: TextStyle(
                                              fontSize: 12.sp,
                                              fontWeight: FontWeight.w400),
                                        )
                                      ],
                                    ),
                                    Text(
                                      "Open",
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 13.sp,
                                      ),
                                    )
                                  ],
                                ),
                                const SizedBox(
                                  height: Sizes.xl,
                                ),
                                Row(
                                  children: [
                                    Expanded(
                                        child: Row(
                                      children: [
                                        const Icon(
                                          Icons.phone,
                                          color: CColors.success,
                                        ),
                                        const SizedBox(
                                          width: Sizes.sm,
                                        ),
                                        Text(
                                          "(7217370990)",
                                          style: Theme.of(context)
                                              .textTheme
                                              .titleLarge,
                                        )
                                      ],
                                    )),
                                    Expanded(
                                        child: Row(
                                      children: [
                                        const Icon(
                                          Icons.email_outlined,
                                          color: CColors.info,
                                        ),
                                        const SizedBox(
                                          width: Sizes.sm,
                                        ),
                                        Expanded(
                                          child: Text(
                                            "ajju@extensioncrm.com",
                                            style: Theme.of(context)
                                                .textTheme
                                                .titleLarge!
                                                .copyWith(
                                                    overflow:
                                                        TextOverflow.ellipsis),
                                          ),
                                        )
                                      ],
                                    ))
                                  ],
                                ),
                                const SizedBox(
                                  height: Sizes.xl,
                                ),
                                Row(
                                  children: [
                                    const Icon(
                                      Icons.location_on_outlined,
                                      color: CColors.error,
                                    ),
                                    const SizedBox(
                                      width: Sizes.sm,
                                    ),
                                    Expanded(
                                      child: Text(
                                        " Plot No.4, Third Floor, Near Metro Pillar No. 599 Milestone, Faridabad, Haryana 121003",
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyLarge,
                                        overflow: TextOverflow
                                            .visible, // Ensures the text is fully visible
                                        maxLines:
                                            null, // Allows unlimited lines
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                )
              ],
            )));
  }
}
