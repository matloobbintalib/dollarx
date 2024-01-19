import 'package:dollarx/utils/extensions/extended_context.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../constants/app_colors.dart';

class BottomNavIcon extends StatelessWidget {
  final VoidCallback callback;
  final String label;
  final String filledPath;
  final bool isSelected;

  const BottomNavIcon({
    Key? key,
    required this.callback,
    required this.label,
    required this.filledPath,
    required this.isSelected
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: callback,
      behavior: HitTestBehavior.opaque,
      child: Container(
        color: isSelected ? AppColors.secondary:AppColors.fieldColor,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(filledPath, height: 24,width: 24,),
            SizedBox(height: 6,),
            Text(
              label,
              style: context.textTheme.bodySmall?.copyWith(fontSize: 10),
            ),
          ],
        ),
      ),
    );
  }
}
