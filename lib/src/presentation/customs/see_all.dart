import 'package:quickdeal/src/core/router/router.dart';
import 'package:quickdeal/src/core/utils/ui_utils/extensions.dart';

import '../../core/utils/ui_utils/constants/colors.dart';

Widget seeAll({required void Function()? onPressed, String? text = "See All"}) {
  return GestureDetector(
    onTap: onPressed,
    child: Row(
      children: [
        Text(
          text!,
          style: TextStyle(fontSize: 15.sp, color: CColors.primary),
        ),
        Icon(Icons.arrow_forward_ios_rounded,
            size: 15.sp, color: CColors.primary),
      ],
    ),
  );
}
