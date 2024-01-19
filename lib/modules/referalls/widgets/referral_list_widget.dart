
import 'package:dollarx/constants/app_colors.dart';
import 'package:dollarx/utils/extensions/extended_context.dart';
import 'package:flutter/cupertino.dart';

class ReferralListWidget extends StatelessWidget {
  final int index ;
  const ReferralListWidget({super.key, required this.index});

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
            child: Text("DAX0010045",
              style: context.textTheme.bodySmall?.copyWith(fontSize: 11),),
          ),
          SizedBox(width: 8,),
          Expanded(
            child: Text("DAX0010045",
              style: context.textTheme.bodySmall?.copyWith(fontSize: 11),),
          ),
        ],
      ),
    );
  }
}
