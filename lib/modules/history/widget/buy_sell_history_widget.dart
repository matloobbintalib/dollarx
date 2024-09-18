

import 'package:dollarax/constants/app_colors.dart';
import 'package:dollarax/modules/history/models/bonus_history_response.dart';
import 'package:dollarax/modules/history/models/exchange_history_response.dart';
import 'package:dollarax/modules/p2p_exchange/models/p2p_exchange_history_response.dart';
import 'package:dollarax/utils/custom_date_time_picker.dart';
import 'package:dollarax/utils/extensions/extended_context.dart';
import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';

class BuySellHistoryWidget extends StatelessWidget {
  final P2PExchangeModel exchangeHistoryModel;
  const BuySellHistoryWidget({super.key, required this.exchangeHistoryModel});

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
                Text('${exchangeHistoryModel.sellAmount} ${exchangeHistoryModel.sellCurrency}',
                  style: context.textTheme.bodyMedium?.copyWith(color: AppColors.secondary, fontWeight: FontWeight.w600),textAlign: TextAlign.center,),
                Text('${exchangeHistoryModel.buyAmount} ${exchangeHistoryModel.buyCurrency}',
                  style: context.textTheme.bodySmall?.copyWith(color: AppColors.white, fontWeight: FontWeight.w300,overflow: TextOverflow.ellipsis),textAlign: TextAlign.center,),
              ],
            ),
          ),
          Expanded(
            child:Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(changeDateTimeFormat1(exchangeHistoryModel.createdAt, 'yyyy-MM-dd'),
                  style: context.textTheme.bodyMedium?.copyWith(color: AppColors.white, fontWeight: FontWeight.w600),textAlign: TextAlign.center,),
                Text(exchangeHistoryModel.p2PType,
                  style: context.textTheme.bodySmall?.copyWith(color:AppColors.white, fontWeight: FontWeight.w500, overflow: TextOverflow.ellipsis),textAlign: TextAlign.center,),
              ],
            ),
          ),
        ],
      ),
    );
  }



}
