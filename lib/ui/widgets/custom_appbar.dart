import 'package:dollarx/ui/widgets/empty_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:dollarx/constants/app_colors.dart';
import 'package:dollarx/utils/utils.dart';

import '../../config/routes/nav_router.dart';

class CustomAppbar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final bool? leftBorder;
  final bool? backArrow;

  const CustomAppbar({super.key, required this.title, this.leftBorder = false, this.backArrow = true});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Color(0xFF323335),
      title: Text(
        title,style: context.textTheme.bodyLarge,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: leftBorder != true ? BorderRadius.only(bottomLeft: Radius.circular(20),topLeft: Radius.circular(20)) : BorderRadius.zero,
      ),
      systemOverlayStyle: SystemUiOverlayStyle(
        statusBarColor: AppColors.fieldColor,
        statusBarIconBrightness: Brightness.light, // For Android (dark icons)
        statusBarBrightness: Brightness.light,
      ),
      flexibleSpace: Container(
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: AppColors.secondary, // Border color for the bottom side
              width: 1.0, // Border width
            ),
            left: leftBorder != true ? BorderSide(
              color: AppColors.secondary, // Border color for the right side
              width: 1.0, // Border width
            ):  BorderSide(),
          ),
          borderRadius: leftBorder != true ? BorderRadius.only(bottomLeft: Radius.circular(20),topLeft: Radius.circular(20)) : BorderRadius.zero,
        ),
      ),
      leading: backArrow == true ? IconButton(
        onPressed: () {
          NavRouter.pop(context);
        },
        icon: Image.asset("assets/images/png/ic_back_arrow.png", width: 26,),
      ): EmptyWidget(),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
