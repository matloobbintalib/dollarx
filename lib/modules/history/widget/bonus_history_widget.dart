

import 'package:dollarx/constants/app_colors.dart';
import 'package:dollarx/modules/history/models/bonus_history_response.dart';
import 'package:dollarx/utils/extensions/extended_context.dart';
import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';

class BonusHistoryWidget extends StatelessWidget {
  final BonusHistoryModel bonusHistoryModel;
  const BonusHistoryWidget({super.key, required this.bonusHistoryModel});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 12)+EdgeInsets.only(bottom: 8),
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),color: AppColors.fieldColor
      ),

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.asset("assets/images/png/currency_icon.png", width: 40,height: 40,color: AppColors.secondary,),
              SizedBox(width: 10,),
              Expanded(
                child:Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(bonusHistoryModel.type.toString().toLowerCase() == "debit"? "Bonus":"Withdraw",
                      style: context.textTheme.bodyMedium?.copyWith(color: AppColors.white, fontWeight: FontWeight.w600),textAlign: TextAlign.center,),
                    Text(changeDateFormat(bonusHistoryModel.createdAt),
                      style: context.textTheme.bodySmall?.copyWith(color: AppColors.white, fontWeight: FontWeight.w300,overflow: TextOverflow.ellipsis),textAlign: TextAlign.center,),
                  ],
                ),
              ),
              Expanded(
                child:Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(roundTwoDecimal(bonusHistoryModel.amount)+" USDT",
                      style: context.textTheme.bodyMedium?.copyWith(color: AppColors.white, fontWeight: FontWeight.w600),textAlign: TextAlign.center,),
                    // Text(bonusHistoryModel.type,
                    //   style: context.textTheme.bodySmall?.copyWith(color: AppColors.secondary, fontWeight: FontWeight.w300, overflow: TextOverflow.ellipsis),textAlign: TextAlign.center,),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 6,),
          Text(bonusHistoryModel.description,
              style: context.textTheme.bodySmall?.copyWith(color: AppColors.white, fontWeight: FontWeight.w300)),
        ],
      ),
    );
  }

  String roundTwoDecimal(String value){
    double number = double.parse(value);
    return number.toStringAsFixed(2);
  }
  String changeDateFormat(String inputDate) {
    DateTime dateTime = DateTime.parse(inputDate);
    String formattedDate = DateFormat('dd-MM-yyyy').format(dateTime);
    return formattedDate;
  }
}
