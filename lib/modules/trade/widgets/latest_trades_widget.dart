import 'package:dollarax/constants/app_colors.dart';
import 'package:dollarax/modules/trade/cubit/latest_trades/latest_trades_cubit.dart';
import 'package:dollarax/modules/trade/cubit/latest_trades/latest_trades_state.dart';
import 'package:dollarax/ui/widgets/loading_indicator.dart';
import 'package:dollarax/ui/widgets/primary_button.dart';
import 'package:dollarax/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LatestTradesWidget extends StatefulWidget {
  final String latestBtcRate;

  const LatestTradesWidget({super.key, required this.latestBtcRate});

  @override
  State<LatestTradesWidget> createState() => _LatestTradesWidgetState();
}

class _LatestTradesWidgetState extends State<LatestTradesWidget> {
  final buyListController = ScrollController();
  final sellListController = ScrollController();

  void scrollUpSellList() {
    final double start = 0;
    sellListController.jumpTo(start);
    scrollDownSellList();
  }
 void scrollDownSellList() {
    final double end = sellListController.position.maxScrollExtent;
    sellListController.animateTo(
        end, duration: Duration(seconds: 4), curve: Curves.easeIn);
  }

  void scrollUpBuyList() {
    final double start = 0;
    buyListController.jumpTo(start);
    scrollDownBuyList();
  }
  void scrollDownBuyList() {
    final double end = buyListController.position.maxScrollExtent;
    buyListController.animateTo(
        end, duration: Duration(seconds: 4), curve: Curves.easeIn);
  }

  @override
  void initState() {
    super.initState();
    sellListController.addListener(listenScrollingSellList);
    buyListController.addListener(listenScrollingBuyList);
  }
  void listenScrollingSellList() {
    if (sellListController.position.atEdge) {
      final isTop = sellListController.position.pixels == 0;
      if (isTop) {
        scrollDownSellList();
      } else {
        scrollUpSellList();
      }
    }
  }
  void listenScrollingBuyList() {
    if (buyListController.position.atEdge) {
      final isTop = buyListController.position.pixels == 0;
      if (isTop) {
        scrollDownBuyList();
      } else {
        scrollUpBuyList();
      }
    }
  }
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LatestTradeCubit,
        LatestTradeState>(
      builder: (context, latestTradeState) {
        if (latestTradeState.latestTradeStatus ==
            LatestTradeStatus.loading) {
          return LoadingIndicator();
        }
        WidgetsBinding.instance
            .addPostFrameCallback((_) {
          scrollDownBuyList();
          scrollDownSellList();
        });
        return Container(
          child: Column(
            children: [
              Row(
                children: [
                  Text('Price',
                      style: context
                          .textTheme.bodySmall
                          ?.copyWith(fontSize: 10)),
                  Spacer(),
                  Text('Amount',
                      style: context
                          .textTheme.bodySmall
                          ?.copyWith(fontSize: 10))
                ],
              ),
              Row(
                children: [
                  Text('(XAU)',
                      style: context
                          .textTheme.bodySmall
                          ?.copyWith(fontSize: 10)),
                  Spacer(),
                  Text('(USD)',
                      style: context
                          .textTheme.bodySmall
                          ?.copyWith(fontSize: 10))
                ],
              ),
              SizedBox(
                height: 6,
              ),
              Container(
                height: MediaQuery
                    .of(context)
                    .size
                    .height * .15,
                child: ListView.builder(
                    controller: sellListController,
                    itemCount: latestTradeState
                        .sellTrades.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Row(
                        children: [
                          Text(
                              latestTradeState
                                  .sellTrades[index]
                                  .tradeCloseBtcRate,
                              style: context
                                  .textTheme.bodySmall
                                  ?.copyWith(
                                  fontSize: 10,
                                  color: Colors.red)),
                          Spacer(),
                          Text(
                              latestTradeState
                                  .sellTrades[index]
                                  .tradeClosingAmountUsd,
                              style: context
                                  .textTheme.bodySmall
                                  ?.copyWith(
                                  fontSize: 10,
                                  fontWeight:
                                  FontWeight
                                      .w500))
                        ],
                      );
                    }),
              ),
              SizedBox(
                height: 10,
              ),
              Text(widget.latestBtcRate,
                style: context.textTheme.titleLarge
                    ?.copyWith(
                    color:
                    AppColors.primaryGreen),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                height: MediaQuery
                    .of(context)
                    .size
                    .height * .15,
                child: ListView.builder(
                    controller: buyListController,
                    itemCount: latestTradeState.buyTrades.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Row(
                        children: [
                          Text(
                              latestTradeState
                                  .buyTrades[index]
                                  .tradeCloseBtcRate,
                              style: context
                                  .textTheme.bodySmall
                                  ?.copyWith(
                                  fontSize: 10,
                                  color: AppColors
                                      .primaryGreen)),
                          Spacer(),
                          Text(
                              latestTradeState
                                  .buyTrades[index]
                                  .tradeClosingAmountUsd,
                              style: context
                                  .textTheme.bodySmall
                                  ?.copyWith(
                                  fontSize: 10,
                                  fontWeight:
                                  FontWeight
                                      .w500))
                        ],
                      );
                    }),
              ),
            ],
          ),
        );
      },
    );
  }
}
