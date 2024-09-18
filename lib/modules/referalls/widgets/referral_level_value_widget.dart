import 'package:dollarax/utils/extensions/extended_context.dart';
import 'package:flutter/cupertino.dart';

import '../../../constants/app_colors.dart';

class ReferralLevelValueWidget extends StatelessWidget {
  final String value;
  const ReferralLevelValueWidget({super.key,  required this.value});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(4),
            topRight: Radius.circular(4)),
        color: AppColors.offWhiteColor,
      ),
      child: Text(
        "\$ $value",
        style: context.textTheme.bodySmall
            ?.copyWith(color: AppColors.black, fontSize: 9),
        textAlign: TextAlign.center,
      ),
      padding: EdgeInsets.symmetric(vertical: 4),
    );
  }
}
