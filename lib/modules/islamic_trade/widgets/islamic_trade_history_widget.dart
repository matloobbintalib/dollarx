import 'package:dollarax/constants/app_colors.dart';
import 'package:dollarax/modules/islamic_trade/models/islamic_trade_history_response.dart';
import 'package:dollarax/ui/widgets/primary_button.dart';
import 'package:dollarax/utils/custom_date_time_picker.dart';
import 'package:dollarax/utils/extensions/extended_context.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class IslamicTradeHistoryWidget extends StatelessWidget {
  final IslamicTradeHistoryModel model;
  final VoidCallback closeTrade;

  const IslamicTradeHistoryWidget(
      {super.key, required this.model, required this.closeTrade});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 2, vertical: 8),
      padding: EdgeInsets.all(6),
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.secondary, width: 1.5),
        borderRadius: BorderRadius.circular(6),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: 10,
              ),
              Expanded(
                flex: 2,
                child: Text(
                  model.copy_trade_item,
                  style: context.textTheme.bodyMedium
                      ?.copyWith(fontWeight: FontWeight.w400),
                ),
              ),
              SizedBox(
                width: 6,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'Status',
                      style: context.textTheme.bodySmall
                          ?.copyWith(fontWeight: FontWeight.w300),
                    ),
                    SizedBox(
                      height: 4,
                    ),
                    Text(
                      model.tradeType,
                      style: context.textTheme.bodySmall
                          ?.copyWith(fontWeight: FontWeight.w300),
                    ),
                  ],
                ),
              ),
              SizedBox(
                width: 16,
              ),
              Expanded(
                flex: 2,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'Amount',
                      style: context.textTheme.bodySmall
                          ?.copyWith(fontWeight: FontWeight.w300),
                    ),
                    SizedBox(
                      height: 4,
                    ),
                    Text(
                      '${model.amount} USD',
                      style: context.textTheme.bodySmall
                          ?.copyWith(fontWeight: FontWeight.w300, fontSize: 10),
                    ),
                  ],
                ),
              ),
              SizedBox(
                width: 10,
              ),

              model.status != 'Sold'
                  ? Column(
                      children: [
                        Text(
                          'Active',
                          style: TextStyle(fontSize: 8, color: Colors.green),
                        ),
                        SizedBox(
                          height: 6,
                        ),
                        PrimaryButton(
                          onPressed: closeTrade,
                          title: 'Sold',
                          fontSize: 14,
                          titleColor: Colors.white,
                          height: 34,
                          width: 76,
                          borderRadius: 12,
                          fontWeight: FontWeight.w400,
                          backgroundColor: AppColors.black,
                          borderColor: AppColors.secondary,
                        ),
                      ],
                    )
                  : PrimaryButton(
                      onPressed: (){},
                      title: 'Closed',
                      fontSize: 14,
                      titleColor: Colors.white,
                      height: 34,
                      width: 76,
                      borderRadius: 12,
                      fontWeight: FontWeight.w400,
                      backgroundColor: AppColors.black,
                      borderColor: AppColors.secondary,
                    ),
            ],
          ),
          Padding(padding: EdgeInsets.only(left: 10, bottom: 4),child: Row(
            children: [
              Expanded(child: Row(
                children: [
                  Text(
                    'Created Date : ',
                    style: context.textTheme.bodySmall
                        ?.copyWith(fontWeight: FontWeight.w300),
                  ),Text(
                    changeDateTimeFormat1(model.createdAt, 'MMM dd, YYYY'),
                    style: context.textTheme.bodySmall
                        ?.copyWith(fontWeight: FontWeight.w300),
                  ),
                ],
              )),
              SizedBox(width: 10,),
              Expanded(child: Row(children: [
                Text(
                  'Sold Date : ',
                  style: context.textTheme.bodySmall
                      ?.copyWith(fontWeight: FontWeight.w300),
                ),Text(
                  model.soldDate,
                  style: context.textTheme.bodySmall
                      ?.copyWith(fontWeight: FontWeight.w300),
                ),
              ],))

            ],
          ),),
        ],
      ),
    );
  }
}
