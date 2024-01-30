

import 'package:dollarx/constants/app_colors.dart';
import 'package:dollarx/utils/extensions/extended_context.dart';
import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';

import '../models/profit_history_response.dart';

class ProfitHistoryWidget extends StatelessWidget {
  final ProfitHistoryModel profitHistoryModel;
  const ProfitHistoryWidget({super.key, required this.profitHistoryModel});

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
                flex: 1,
                child:Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(roundTwoDecimal(profitHistoryModel.total),
                      style: context.textTheme.bodyMedium?.copyWith(color: AppColors.white, fontWeight: FontWeight.w600),textAlign: TextAlign.center,),
                    Text(changeDateFormat(profitHistoryModel.createdAt),
                      style: context.textTheme.bodySmall?.copyWith(color: AppColors.white, fontWeight: FontWeight.w300),textAlign: TextAlign.center,),
                  ],
                ),
              ),
              Expanded(
                flex: 2,
                child:Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(roundTwoDecimal(profitHistoryModel.amount) +" "+profitHistoryModel.currency,
                      style: context.textTheme.bodyMedium?.copyWith(color: AppColors.white, fontWeight: FontWeight.w600),textAlign: TextAlign.center,),
                    Text(profitHistoryModel.type,
                      style: context.textTheme.bodySmall?.copyWith(color: AppColors.secondary, fontWeight: FontWeight.w300, overflow: TextOverflow.ellipsis),textAlign: TextAlign.center,),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 6,),
          Text(profitHistoryModel.description,
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
