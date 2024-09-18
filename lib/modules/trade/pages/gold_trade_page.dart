import 'dart:async';
import 'dart:convert';

import 'package:candlesticks/candlesticks.dart';
import 'package:dollarax/config/config.dart';
import 'package:dollarax/constants/app_colors.dart';
import 'package:dollarax/core/di/service_locator.dart';
import 'package:dollarax/modules/history/pages/exchange_history_page.dart';
import 'package:dollarax/modules/history/pages/trade_history_page.dart';
import 'package:dollarax/modules/trade/cubit/active_trade/active_trade_cubit.dart';
import 'package:dollarax/modules/trade/cubit/end_trade/end_trade_cubit.dart';
import 'package:dollarax/modules/trade/cubit/end_trade/end_trade_state.dart';
import 'package:dollarax/modules/trade/cubit/gold_live_data/gold_live_data_cubit.dart';
import 'package:dollarax/modules/trade/cubit/gold_live_data/gold_live_data_state.dart';
import 'package:dollarax/modules/trade/cubit/gold_rate/gold_rate_cubit.dart';
import 'package:dollarax/modules/trade/cubit/gold_rate/gold_rate_state.dart';
import 'package:dollarax/modules/trade/cubit/gold_trade/gold_trade_cubit.dart';
import 'package:dollarax/modules/trade/cubit/gold_trade/gold_trade_state.dart';
import 'package:dollarax/modules/trade/cubit/latest_trades/latest_trades_cubit.dart';
import 'package:dollarax/modules/trade/cubit/start_trade/start_trade_cubit.dart';
import 'package:dollarax/modules/trade/cubit/start_trade/start_trade_state.dart';
import 'package:dollarax/modules/trade/cubit/take_profit_stop_loss/trade_tpsl_cubit.dart';
import 'package:dollarax/modules/trade/models/gold_data_model.dart';
import 'package:dollarax/modules/trade/models/graph_input.dart';
import 'package:dollarax/modules/trade/widgets/gold_graph_widget.dart';
import 'package:dollarax/modules/trade/widgets/latest_trades_widget.dart';
import 'package:dollarax/modules/trade/widgets/trade_start_end_widget.dart';
import 'package:dollarax/modules/trade/widgets/trade_tpsl_widget.dart';
import 'package:dollarax/ui/widgets/custom_appbar.dart';
import 'package:dollarax/ui/widgets/empty_widget.dart';
import 'package:dollarax/ui/widgets/loading_indicator.dart';
import 'package:dollarax/ui/widgets/primary_button.dart';
import 'package:dollarax/utils/custom_date_time_picker.dart';
import 'package:dollarax/utils/display/display_utils.dart';
import 'package:dollarax/utils/extensions/extended_context.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

import '../../../ui/widgets/toast_loader.dart';

class GoldTradePage extends StatefulWidget {
  const GoldTradePage({super.key});

  @override
  State<GoldTradePage> createState() => _GoldTradePageState();
}

class _GoldTradePageState extends State<GoldTradePage> {
  List<Candle> candles = [];
  bool themeIsDark = false;
  bool isAmountFetched = true;
  String tradeBtcRate = '0.0';
  String latestGoldRate = '0.0';

  String selectedTime = '1min';

  // String selectedTime = '1Min';
  late Timer _timer;
  late Timer _activeApiTimer;

  String day = '';
  bool isBeforeNine = false;

  @override
  void initState() {
    super.initState();
    context.read<GoldTradeCubit>()
      ..goldTradeData(GraphInput(graph_records: selectedTime));

    /*day = DateFormat('EEEE').format(DateTime.now());
    DateTime now = DateTime.now();
    DateTime nineAM = DateTime(now.year, now.month, now.day, 9, 0, 0);
    isBeforeNine = now.isBefore(nineAM);
    if (day != 'Saturday' || day != 'Sunday') {
      if ((day == 'Monday' && !isBeforeNine) || day != 'Monday') {

      }
    }*/
    // context.read<GoldLiveDataCubit>().goldLiveDataData(
    //     changeDateTimeFormat1(DateTime.now(), "yyyy-MM-dd"), selectedTime);

    context.read<GoldRateCubit>()
      ..goldLatestRate().then((value) {
        context.read<ActiveTradeCubit>()..activeTradeData(isLoading: true);
      });
    //latest rate
    _timer = Timer.periodic(Duration(seconds: 10), (Timer timer) {
      context.read<GoldRateCubit>()..goldLatestRate();
    });

    //active trades and graph data
    _activeApiTimer = Timer.periodic(Duration(seconds: 30), (Timer timer) {
      print('api call starting...');
      context.read<ActiveTradeCubit>()..activeTradeData(isLoading: false);

      //live data from api
      context.read<GoldTradeCubit>()
        ..goldTradeData(GraphInput(graph_records: selectedTime),
            isLoading: false);

      //live data from gold live api
      // context.read<GoldLiveDataCubit>().goldLiveDataData(
      //     changeDateTimeFormat1(DateTime.now(), "yyyy-MM-dd"),
      //     selectedTime);
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    _activeApiTimer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => StartTradeCubit(sl()),
        ),
        BlocProvider(
          create: (context) => EndTradeCubit(sl()),
        ),
        BlocProvider(
          create: (context) => TradeTPSLCubit(sl()),
        ),
        BlocProvider(
          create: (context) =>
          LatestTradeCubit(sl())..latestTradeData(isLoading: true),
        ),
      ],
      child: Scaffold(
        appBar: CustomAppbar(
          title: "Trade",
          backArrow: false,
        ),
        backgroundColor: Colors.black,
        body: /*(day == 'Saturday' || day == 'Sunday') ||
                (day == 'Monday' && isBeforeNine)
            ? Stack(
                children: [
                  Image.asset(
                    'assets/images/png/trade_dummy_page.png',
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height,
                    fit: BoxFit.fill,
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height,
                    decoration:
                        BoxDecoration(color: Colors.black.withOpacity(.85)),
                    child: Center(
                      child: Text('Saturday & Sunday market closed',
                          style: TextStyle(color: Colors.white)),
                    ),
                  )
                ],
              )
            : */
        BlocConsumer<GoldRateCubit, GoldRateState>(
          listener: (context, goldRateState) {
            if (goldRateState.goldRateStatus == GoldRateStatus.success) {
              if (isAmountFetched) {
                isAmountFetched = false;
                tradeBtcRate = goldRateState.goldLatestRateModel!.tradeRate
                    .replaceAll(',', '');
              }
              latestGoldRate = goldRateState.goldLatestRateModel!.tradeRate
                  .toString()
                  .replaceAll(',', '');
              setState(() {});
            }
          },
          builder: (context, state) {
            return BlocConsumer<EndTradeCubit, EndTradeState>(
              listener: (context, state) {
                if (state.endTradeStatus == EndTradeStatus.loading) {
                  ToastLoader.show();
                } else if (state.endTradeStatus == EndTradeStatus.success) {
                  ToastLoader.remove();
                  DisplayUtils.showToast(context, state.message);
                  context.read<ActiveTradeCubit>()
                    ..activeTradeData().then((value) {
                      context.read<LatestTradeCubit>()..latestTradeData();
                    });
                } else if (state.endTradeStatus == EndTradeStatus.error) {
                  ToastLoader.remove();
                  DisplayUtils.showToast(context, state.message);
                }
              },
              builder: (context, state) {
                return BlocConsumer<StartTradeCubit, StartTradeState>(
                  listener: (context, startTradeState) {
                    if (startTradeState.startTradeStatus ==
                        StartTradeStatus.loading) {
                      ToastLoader.show();
                    } else if (startTradeState.startTradeStatus ==
                        StartTradeStatus.success) {
                      ToastLoader.remove();
                      DisplayUtils.showToast(context, startTradeState.message);
                      context.read<ActiveTradeCubit>()..activeTradeData();
                    } else if (startTradeState.startTradeStatus ==
                        StartTradeStatus.error) {
                      ToastLoader.remove();
                      DisplayUtils.showToast(context, startTradeState.message);
                    }
                  },
                  builder: (context, state) {
                    return SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 12,
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 16),
                            child: Text(
                              "XAU-USD",
                              style: context.textTheme.titleLarge,
                            ),
                          ),
                          SizedBox(
                            height: 30,
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 10),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                    child: LatestTradesWidget(
                                      latestBtcRate:
                                      roundTwoDecimal(latestGoldRate),
                                    )),
                                SizedBox(
                                  width: 8,
                                ),
                                Expanded(
                                  child: Column(
                                    children: [
                                      Container(
                                        height: 30,
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 10),
                                        decoration: BoxDecoration(
                                            borderRadius:
                                            BorderRadius.circular(6),
                                            color: AppColors.secondary),
                                        child: Row(
                                          children: [
                                            Expanded(
                                              child: PrimaryButton(
                                                onPressed: () {
                                                  NavRouter.push(context,
                                                      TradeHistoryPage());
                                                },
                                                title: 'View Trade history',
                                                height: 30,
                                                fontSize: 12,
                                              ),
                                            ),
                                            Image.asset(
                                              "assets/images/png/ic_arrow_forward.png",
                                              width: 12,
                                              height: 12,
                                              color: Colors.black,
                                            )
                                          ],
                                        ),
                                      ),
                                      SizedBox(
                                        height: 20,
                                      ),
                                      TradeStartEndWidget(
                                        tradeBtcRate:
                                        roundTwoDecimal(tradeBtcRate),
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          TradeTPSLWidget(
                              tradeBtcRate: roundTwoDecimal(latestGoldRate)),
                          Divider(
                            color: Colors.white,
                            thickness: .5,
                          ),
                          BlocBuilder<GoldTradeCubit, GoldTradeState>(
                            builder: (context, goldTradeState) {
                              if (goldTradeState.goldTradeStatus ==
                                  GoldTradeStatus.loading) {
                                return Center(
                                  child: LoadingIndicator(),
                                );
                              }
                              if (goldTradeState.goldTradeStatus ==
                                  GoldTradeStatus.error){
                                return Center(child: Text(goldTradeState.message),);
                              }
                              if (goldTradeState.goldTradeStatus ==
                                  GoldTradeStatus.success) {
                                List<Candle> list = goldTradeState.goldTradeList
                                    .map((e) => Candle(
                                    date: e.date,
                                    high: e.highRate,
                                    low: e.lowRate,
                                    open: e.openRate,
                                    close: e.closeRate,
                                    volume: 0.00010000))
                                    .toList();
                                return GoldGraphWidget(
                                  candles: list,
                                  onSelectedTime: (String interval) {
                                    selectedTime = interval;
                                    context.read<GoldTradeCubit>()
                                      ..goldTradeData(
                                          GraphInput(graph_records: interval),
                                          isLoading: false);
                                  },
                                );
                              }
                              return EmptyWidget();
                            },
                          ),
                          /*BlocBuilder<GoldLiveDataCubit,
                                    GoldLiveDataState>(
                                  builder: (context, goldLiveDataState) {
                                    if (goldLiveDataState.goldLiveDataStatus ==
                                        GoldLiveDataStatus.loading) {
                                      return Center(
                                        child: LoadingIndicator(),
                                      );
                                    } else if (goldLiveDataState
                                            .goldLiveDataStatus ==
                                        GoldLiveDataStatus.success) {
                                      List<Candle> list = goldLiveDataState
                                          .candles
                                          .map((e) => Candle(
                                              date: e.date,
                                              high: e.high,
                                              low: e.low,
                                              open: e.open,
                                              close: e.close,
                                              volume: 0.00010000))
                                          .toList();
                                      return GoldGraphWidget(
                                        candles: list,
                                        onSelectedTime: (String interval) {
                                          selectedTime = interval;
                                          String intervalValue = '';
                                          if (interval == '1Min') {
                                            intervalValue = '1min';
                                          } else if (interval == '5Min') {
                                            intervalValue = '5min';
                                          } else if (interval == '30Min') {
                                            intervalValue = '30min';
                                          } else if (interval == '1D') {
                                            intervalValue = '60min';
                                          } else if (interval == '3D') {
                                            intervalValue = '45Hour';
                                          } else if (interval == '1W') {
                                            intervalValue = '194Hour';
                                          }

                                          context
                                              .read<GoldLiveDataCubit>()
                                              .goldLiveDataData(
                                                  changeDateTimeFormat1(
                                                      DateTime.now(),
                                                      "yyyy-MM-dd"),
                                                  intervalValue);
                                        },
                                      );
                                    }
                                    return EmptyWidget();
                                  },
                                )*/
                        ],
                      ),
                    );
                  },
                );
              },
            );
          },
        ),
      ),
    );
  }
}
