import 'package:quickdeal/src/presentation/features/dashboard/subscreens/profile/profile.dart';
import 'package:quickdeal/src/presentation/features/followup/states/followup_list_state.dart';
import 'package:quickdeal/src/presentation/features/followup/widgets/followup_tile.dart';

import '../../../core/router/routes.dart';
import '../../customs/custom_icon_button.dart';
import 'widgets/lead_filter.dart';

class FollowupListScreen extends ConsumerStatefulWidget {
  const FollowupListScreen({super.key, required this.propertyId});
  final String? propertyId;

  @override
  ConsumerState<FollowupListScreen> createState() => _FollowupScreenState();
}

class _FollowupScreenState extends ConsumerState<FollowupListScreen> {
  @override
  void initState() {
    Future.microtask(() => ref
        .read(followupListStateProvider.notifier)
        .fetchFollowup(widget.propertyId));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final followupState = ref.watch(followupListStateProvider);
    final followupNotifier = ref.read(followupListStateProvider.notifier);
    var isDark = context.isDarkMode;

    return Scaffold(
        appBar: AppBar(
          title: const Text("Follow-Up"),
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
                      return followupNotifier.fetchFollowup(widget.propertyId);
                    },
                    color: isDark ? CColors.textWhite : CColors.primary,
                    child: followupState.isLoading
                        ? const SizedBox()
                        : followupState.followupList.isEmpty
                            ? const Center(child: Text('No Follow-Up found.'))
                            : ListView.separated(
                                separatorBuilder: (context, index) {
                                  return 15.hBox;
                                },
                                shrinkWrap: true,
                                itemCount: followupState.followupList.length,
                                itemBuilder: (context, index) {
                                  final followupData =
                                      followupState.followupList[index];
                                  // ignore: unrelated_type_equality_checks
                                  if (index ==
                                      followupState.followupList[index]) {
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
                                  return FollowupTile(
                                    isDark: isDark,
                                    name: followupData.name,
                                    phone: followupData.phone.toString(),
                                    completed: followupData.completed,
                                  );
                                },
                              ),
                  ),
                )
              ],
            )),
        floatingActionButton: widget.propertyId != null
            ? FloatingActionButton(
                onPressed: () {
                  context.pushNamed(Routes.followupFormScreen);
                },
                child: const Icon(Icons.add))
            : const SizedBox());
  }
}
