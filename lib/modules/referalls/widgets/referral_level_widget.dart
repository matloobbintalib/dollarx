

import 'package:dollarx/ui/widgets/on_click.dart';
import 'package:dollarx/utils/extensions/extended_context.dart';
import 'package:flutter/cupertino.dart';

import '../../../constants/app_colors.dart';

class ReferralLevelWidget extends StatelessWidget {
  final VoidCallback onTap ;
  final String title;
  const ReferralLevelWidget({super.key, required this.onTap, required this.title});

  @override
  Widget build(BuildContext context) {
    return OnClick(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
              bottomRight: Radius.circular(4),
              bottomLeft: Radius.circular(4)),
          color: AppColors.secondary,
        ),
        child: Text(
          title,
          style: context.textTheme.bodySmall
              ?.copyWith(color: AppColors.black, fontSize: 9),
          textAlign: TextAlign.center,
        ),
        padding: EdgeInsets.symmetric(vertical: 4),
      ),
    );
  }
}
