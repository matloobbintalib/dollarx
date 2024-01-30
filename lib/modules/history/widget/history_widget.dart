

import 'package:dollarx/constants/app_colors.dart';
import 'package:flutter/material.dart';

class HistoryWidget extends StatelessWidget {
  final String leadingPath;
  final String title;
  final VoidCallback onTap;
  const HistoryWidget({super.key, required this.leadingPath, required this.title, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: ListTile(
        onTap: onTap,
        horizontalTitleGap: 12,
        contentPadding: EdgeInsets.only(left: 20, right: 16),
        leading: Image.asset(
          leadingPath,
          height: 40,
          width: 40,
          color: AppColors.secondary,
        ),
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
