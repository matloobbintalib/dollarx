import 'package:dollarax/constants/app_colors.dart';
import 'package:dollarax/modules/trade/models/active_trade_response.dart';
import 'package:dollarax/modules/trade/models/buy_sell_input.dart';
import 'package:dollarax/ui/widgets/custom_dropdown.dart';
import 'package:dollarax/ui/widgets/primary_button.dart';
import 'package:dollarax/utils/display/display_utils.dart';
import 'package:dollarax/utils/utils.dart';
import 'package:flutter/material.dart';

class EndTradeWidget extends StatelessWidget {
  final ActiveTradeData activeTradeData;
  final VoidCallback endTradePress;
  const EndTradeWidget({super.key, required this.activeTradeData, required this.endTradePress});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.symmetric(
                vertical: 10),
            width: double.infinity,
            decoration: BoxDecoration(
                borderRadius:
                BorderRadius.circular(4),
                color: AppColors.fieldColor),
            child: Column(
              crossAxisAlignment:
              CrossAxisAlignment.center,
              children: [
                Text(
                  'Trade Balance',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 10),
                  textAlign: TextAlign.center,
                ),
                Text(
                  activeTradeData
                      .trade_wallet_balance
                      .toString(),
                  style: TextStyle(
                      color: Colors.green,
                      fontWeight:
                      FontWeight.w500),
                )
              ],
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Container(
            padding: EdgeInsets.symmetric(
                vertical: 10),
            width: double.infinity,
            decoration: BoxDecoration(
                borderRadius:
                BorderRadius.circular(4),
                color: AppColors.fieldColor),
            child: Column(
              crossAxisAlignment:
              CrossAxisAlignment.center,
              children: [
                Text(
                  'Invested Amount',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 10),
                ),
                Text(
                  activeTradeData
                      .activeTrades
                      .tradeAmount
                      .toString(),
                  style: TextStyle(
                      color: Colors.green,
                      fontWeight:
                      FontWeight.w500),
                )
              ],
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Container(
            padding: EdgeInsets.symmetric(
                vertical: 10),
            width: double.infinity,
            decoration: BoxDecoration(
                borderRadius:
                BorderRadius.circular(4),
                color: AppColors.fieldColor),
            child: Column(
              crossAxisAlignment:
              CrossAxisAlignment.center,
              children: [
                Text(
                  'Current  Profit/Loss Amount',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 10),
                  textAlign: TextAlign.center,
                ),
                Text(
                    activeTradeData
                        .finalAmount
                        .toString(),
                    style: TextStyle(
                        color: Colors.green,
                        fontWeight:
                        FontWeight.w500)),
              ],
            ),
          ),
          SizedBox(
            height: 20,
          ),
          PrimaryButton(
            onPressed: endTradePress,
            title: 'End Trade',
            backgroundColor: AppColors.lightRed,
            fontSize: 12,
            height: 26,
            borderColor: AppColors.lightRed,
            titleColor: Colors.white,
            fontWeight: FontWeight.w400,
          )
        ],
      ),
    );
  }
}
