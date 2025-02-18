import '../../../../../customs/circular_container.dart';
import '../profile.dart';

class ProfileIcon extends StatelessWidget {
  const ProfileIcon({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = context.isDarkMode;
    return CircularImage(
      image: isDark ? AssetsConsts.lightLogo : AssetsConsts.darkLogo,
      width: 100.w,
      height: 100.h,
      isNetworkImage: false,
    );
  }
}
