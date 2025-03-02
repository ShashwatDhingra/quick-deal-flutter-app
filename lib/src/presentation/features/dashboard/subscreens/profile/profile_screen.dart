import 'package:quickdeal/src/presentation/global/user_provider.dart';

import '../../../../../core/router/routes.dart';
import 'profile.dart';

class ProfileScreen extends ConsumerStatefulWidget {
  const ProfileScreen({super.key});

  @override
  ConsumerState<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends ConsumerState<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    var dark = context.isDarkMode;
    final user = ref.watch(userProvider);

    return Scaffold(
      body: SizedBox(
        height: double.infinity,
        width: double.infinity,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: Column(
              children: [
                (Sizes.xl * 5).hBox,
                const ProfileIcon(),
                Sizes.md.hBox,
                Text(user?.name ?? '-- name --',
                    style:
                        Theme.of(context).textTheme.headlineMedium!.copyWith()),
                Sizes.xs.hBox,
                Text(
                  user?.email ?? '-- email --',
                  style: Theme.of(context).textTheme.titleMedium!.copyWith(),
                ),
                Sizes.lg.hBox,
                //Edit Profile button
                SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                        onPressed: () {
                          //  ref.read(getProvider).login(
                          //      email.text.toString(),
                          //      password.text.toString(),
                          //      context);
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const ProfileScreen(),
                              ));
                        },
                        child: const Text("Edit Profile"))),
                Sizes.sm.hBox,
                ListView.separated(
                  separatorBuilder: (context, index) {
                    return Padding(
                      padding:
                          const EdgeInsets.symmetric(vertical: (Sizes.iconXs)),
                      child: Divider(
                        color: dark ? CColors.darkGrey : CColors.lightGrey,
                        thickness: dark ? 0.5 : 4,
                      ),
                    );
                  },
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        if (iconAndTitle[index]["title"] == "Logout") {
                          showCupertinoDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return CupertinoAlertDialog(
                                title: const Text("Confirm Logout"),
                                content: const Text(
                                    "Are you sure you want to log out?"),
                                actions: [
                                  CupertinoDialogAction(
                                    isDefaultAction: true,
                                    onPressed: () {
                                      // Dismiss the dialog without logging out
                                      Navigator.of(context).pop();
                                    },
                                    child: const Text("No"),
                                  ),
                                  CupertinoDialogAction(
                                    onPressed: () async {},
                                    child: const Text(
                                      "Yes",
                                      style: TextStyle(color: CColors.error),
                                    ),
                                  ),
                                ],
                              );
                            },
                          );
                        } else if (iconAndTitle[index]["title"] ==
                            "Notification") {
                          context.pushNamed(Routes.notificationScreen);
                        } else if (iconAndTitle[index]["title"] ==
                            "Terms & Conditions") {
                          context.pushNamed(Routes.termsAndConditionScreen);
                        } else if (iconAndTitle[index]["title"] == "Help") {
                          context.pushNamed(Routes.helpAndSupportScreen);
                        }
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Container(
                                width: 40,
                                height: 40,
                                decoration: BoxDecoration(
                                  border: Border.all(width: 0.2),
                                  borderRadius: BorderRadius.circular(20),
                                  color: dark
                                      ? const Color(0xff373737)
                                      : Colors.transparent,
                                ),
                                child: Icon(
                                  iconAndTitle[index]["icon"],
                                  color: dark ? CColors.white : CColors.primary,
                                ),
                              ),
                              Sizes.xl.vBox,
                              Text(
                                iconAndTitle[index]["title"],
                                style: iconAndTitle[index]["title"] == "Logout"
                                    ? Theme.of(context)
                                        .textTheme
                                        .headlineSmall!
                                        .copyWith(color: CColors.error)
                                    : Theme.of(context)
                                        .textTheme
                                        .headlineSmall!
                                        .copyWith(),
                              )
                            ],
                          ),
                          iconAndTitle[index]["title"] == "Logout"
                              ? const SizedBox()
                              : Icon(Icons.arrow_forward_ios,
                                  color:
                                      dark ? CColors.white : CColors.darkGrey)
                        ],
                      ),
                    );
                  },
                  itemCount: iconAndTitle.length,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
