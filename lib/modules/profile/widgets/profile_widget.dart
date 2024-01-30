

import 'package:flutter/material.dart';

class ProfileWidget extends StatelessWidget {
  final String leadingPath;
  final String title;
  final VoidCallback onTap;
  const ProfileWidget({super.key, required this.leadingPath, required this.title, required this.onTap});

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
          width: 40

        ),
        trailing: Image.asset(
          "assets/images/png/ic_arrow_forward.png",
          width: 14,
          height: 14,
        ),
        title: Text(
          title,
          style: TextStyle(color:Colors.white, fontSize: 15),
        ),
      ),
    );
  }
}
