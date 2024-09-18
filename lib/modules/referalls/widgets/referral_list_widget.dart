
import 'package:dollarax/constants/app_colors.dart';
import 'package:dollarax/modules/referalls/models/referral_response.dart';
import 'package:dollarax/utils/extensions/extended_context.dart';
import 'package:flutter/cupertino.dart';

class ReferralListWidget extends StatelessWidget {
  final int index ;
  final LevelReferral levelReferral;
  const ReferralListWidget({super.key, required this.index, required this.levelReferral});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 8),
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.secondary),
        color: AppColors.fieldColor
      ),
      padding: EdgeInsets.symmetric(horizontal: 8,vertical: 6),
      child:Row(
        children: [
          Expanded(
            child: Text((index+1).toString(),
              style: context.textTheme.bodySmall?.copyWith(fontSize: 11),textAlign: TextAlign.left,),
          ),
          SizedBox(width: 8,),
          Expanded(
            child: Text(levelReferral.referralId,
              style: context.textTheme.bodySmall?.copyWith(fontSize: 11),),
          ),
          SizedBox(width: 8,),
          Expanded(
            child: Text(levelReferral.parentId,
              style: context.textTheme.bodySmall?.copyWith(fontSize: 11),),
          ),
        ],
      ),
    );
  }
}
