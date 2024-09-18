import 'package:dollarax/constants/app_colors.dart';
import 'package:dollarax/modules/trade/cubit/active_trade/active_trade_cubit.dart';
import 'package:dollarax/modules/trade/cubit/active_trade/active_trade_state.dart';
import 'package:dollarax/modules/trade/models/active_trade_response.dart';
import 'package:dollarax/ui/widgets/empty_widget.dart';
import 'package:dollarax/ui/widgets/loading_indicator.dart';
import 'package:dollarax/utils/custom_date_time_picker.dart';
import 'package:dollarax/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TradeTPSLWidget extends StatelessWidget {
  final String tradeBtcRate;

  const TradeTPSLWidget({super.key, required this.tradeBtcRate});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ActiveTradeCubit, ActiveTradeState>(
      builder: (context, activeTradeState) {
        if (activeTradeState.activeTradeStatus == ActiveTradeStatus.loading) {
          return Center(child: LoadingIndicator());
        } else if (activeTradeState.activeTradeStatus ==
            ActiveTradeStatus.success) {
          ActiveTrades trade =
              activeTradeState.activeTradeResponse!.data.activeTrades;
          ActiveTradeData? tradeData =
              activeTradeState.activeTradeResponse!.data;
          return Column(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                child: Row(
                  children: [
                    Text('Open Orders',
                        style: context.textTheme.bodySmall?.copyWith(
                            fontSize: 10, fontWeight: FontWeight.w500)),
                    SizedBox(
                      width: 20,
                    ),
                    Text('Position',
                        style: context.textTheme.bodySmall?.copyWith(
                            fontSize: 10, fontWeight: FontWeight.w500))
                  ],
                ),
              ),
              Divider(
                color: Colors.white,
                thickness: .5,
              ),
              Container(
                  padding: EdgeInsets.all(10),
                  color: Color(0xFF1f2630),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Text('XAU Rate',
                                style: context.textTheme.bodySmall?.copyWith(
                                    fontWeight: FontWeight.w300, fontSize: 10)),
                          ),
                          SizedBox(
                            width: 6,
                          ),
                          Expanded(
                            child: Text('Invested Amount',
                                style: context.textTheme.bodySmall?.copyWith(
                                    fontWeight: FontWeight.w300, fontSize: 10)),
                          ),
                          SizedBox(
                            width: 6,
                          ),
                          Expanded(
                            child: Text('Profit/Loss',
                                style: context.textTheme.bodySmall?.copyWith(
                                    fontWeight: FontWeight.w300, fontSize: 10)),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 4,
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: Text(roundTwoDecimal(tradeBtcRate),
                                style: context.textTheme.headlineSmall
                                    ?.copyWith(fontSize: 14)),
                          ),
                          SizedBox(
                            width: 6,
                          ),
                          Expanded(
                            child: Text(trade.tradeAmount,
                                style: context.textTheme.headlineSmall
                                    ?.copyWith(fontSize: 14)),
                          ),
                          SizedBox(
                            width: 6,
                          ),
                          Expanded(
                            child: Text(
                                tradeData.getProfitLossAmount(),
                                style: context.textTheme.headlineSmall
                                    ?.copyWith(
                                        fontSize: 14,
                                        color: tradeData.tradeEffect.toString().toLowerCase() ==
                                                "loss"
                                            ? Colors.red
                                            : AppColors.primaryGreen)),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      Row(
                        children: [
                          Expanded(
                              child: Row(
                            children: [
                              Text('TP/SL',
                                  style: context.textTheme.bodySmall?.copyWith(
                                      fontWeight: FontWeight.w300,
                                      fontSize: 10)),
                              SizedBox(
                                width: 10,
                              ),
                              Expanded(
                                child: Text(
                                    '${trade.trade_take_profit}/${trade.trade_stop_loss}',
                                    style: context.textTheme.headlineSmall
                                        ?.copyWith(fontSize: 14)),
                              ),
                            ],
                          )),
                          SizedBox(
                            width: 6,
                          ),
                          Expanded(
                            child: Text(
                                '${trade.initialTradeRate}/${roundTwoDecimal(tradeBtcRate)}',
                                style: context.textTheme.headlineSmall
                                    ?.copyWith(fontSize: 14)),
                          ),
                          Expanded(
                              child: Row(
                                children: [
                                  Text('Type',
                                      style: context.textTheme.bodySmall?.copyWith(
                                          fontWeight: FontWeight.w300,
                                          fontSize: 10)),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Expanded(
                                    child: Text(
                                        '${trade.tradeType}',
                                        style: context.textTheme.headlineSmall
                                            ?.copyWith(fontSize: 14,color: tradeData.activeTrades
                                            .tradeFinalEffect ==
                                            "Loss"
                                            ? Colors.red
                                            : AppColors.primaryGreen)),
                                  ),
                                ],
                              )),
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                    ],
                  )),
            ],
          );
        }
        return EmptyWidget();
      },
    );
  }
}
