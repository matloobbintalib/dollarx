

import 'package:dollarax/constants/app_colors.dart';
import 'package:dollarax/modules/history/models/bonus_history_response.dart';
import 'package:dollarax/modules/history/models/exchange_history_response.dart';
import 'package:dollarax/utils/custom_date_time_picker.dart';
import 'package:dollarax/utils/extensions/extended_context.dart';
import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';

class ExchangeHistoryWidget extends StatelessWidget {
  final ExchangeHistoryModel exchangeHistoryModel;
  const ExchangeHistoryWidget({super.key, required this.exchangeHistoryModel});

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
          Image.asset("assets/images/png/currency_icon.png", width: 40,height: 40,color: AppColors.secondary,),
          SizedBox(width: 10,),
          Expanded(
            child:Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(exchangeHistoryModel.fundReceiverReferralId.toString(),
                  style: context.textTheme.bodyMedium?.copyWith(color: AppColors.white, fontWeight: FontWeight.w600),textAlign: TextAlign.center,),
                Text(exchangeHistoryModel.createdAt.toString(),
                  style: context.textTheme.bodySmall?.copyWith(color: AppColors.white, fontWeight: FontWeight.w300,overflow: TextOverflow.ellipsis),textAlign: TextAlign.center,),
              ],
            ),
          ),
          Expanded(
            child:Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(exchangeHistoryModel.amount+" USDT",
                  style: context.textTheme.bodyMedium?.copyWith(color: AppColors.white, fontWeight: FontWeight.w600),textAlign: TextAlign.center,),
                Text("XAU to ${exchangeHistoryModel.currency}",
                  style: context.textTheme.bodySmall?.copyWith(color: AppColors.secondary, fontWeight: FontWeight.w300, overflow: TextOverflow.ellipsis),textAlign: TextAlign.center,),
              ],
            ),
          ),
        ],
      ),
    );
  }



}
