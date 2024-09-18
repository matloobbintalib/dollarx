

import 'package:dollarax/constants/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class HistoryWidget extends StatelessWidget {
  final Widget leading;
  final String title;
  final VoidCallback onTap;
  const HistoryWidget({super.key, required this.leading, required this.title, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: ListTile(
        onTap: onTap,
        horizontalTitleGap: 12,
        contentPadding: EdgeInsets.only(left: 20, right: 16),
        leading: leading,
        trailing: Image.asset(
          "assets/images/png/ic_arrow_forward.png",
          width: 14,
          height: 14,
          color: AppColors.secondary,
        ),
        title: Text(
          title,
          style: TextStyle(color:Colors.white, fontSize: 15),
        ),
      ),
    );
  }
}
