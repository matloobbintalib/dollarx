

import 'package:dollarax/constants/app_colors.dart';
import 'package:dollarax/modules/history/models/bonus_history_response.dart';
import 'package:dollarax/modules/trade/models/active_trade_response.dart';
import 'package:dollarax/utils/custom_date_time_picker.dart';
import 'package:dollarax/utils/extensions/extended_context.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TradeHistoryWidget extends StatelessWidget {
  final ActiveTrades activeTradeModel;
  const TradeHistoryWidget({super.key, required this.activeTradeModel});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 12)+EdgeInsets.only(bottom: 8),
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),color: AppColors.fieldColor
      ),

      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child:Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('XAUUSD ${activeTradeModel.tradeType} ${activeTradeModel.tradeAmount}',
                  style: context.textTheme.bodyMedium?.copyWith(color: AppColors.secondary, fontWeight: FontWeight.w600),textAlign: TextAlign.center,),
                Text('${activeTradeModel.initialTradeRate} - ${activeTradeModel.endTradeRate}',
                  style: context.textTheme.bodySmall?.copyWith(color: AppColors.white, fontWeight: FontWeight.w300,overflow: TextOverflow.ellipsis),textAlign: TextAlign.center,),
              ],
            ),
          ),
          Expanded(
            child:Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(changeDateTimeFormat1(activeTradeModel.createdAt, 'yyyy-MM-dd'),
                  style: context.textTheme.bodyMedium?.copyWith(color: AppColors.white, fontWeight: FontWeight.w600),textAlign: TextAlign.center,),
                Text(activeTradeModel.tradeFinalEffect == "Loss"? '-${activeTradeModel.tradeClosingAmount}':'+${activeTradeModel.tradeClosingAmount}',
                  style: context.textTheme.bodySmall?.copyWith(color: activeTradeModel.tradeFinalEffect == "Loss"? Colors.red: AppColors.primaryGreen, fontWeight: FontWeight.w500, overflow: TextOverflow.ellipsis),textAlign: TextAlign.center,),
              ],
            ),
          ),
        ],
      ),
    );
  }



}
