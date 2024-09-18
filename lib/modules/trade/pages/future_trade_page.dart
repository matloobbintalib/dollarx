import 'dart:async';
import 'dart:convert';

import 'package:candlesticks/candlesticks.dart';
import 'package:dollarax/constants/app_colors.dart';
import 'package:dollarax/core/di/service_locator.dart';
import 'package:dollarax/modules/trade/btc_to_usdt/btc_to_usdt_cubit.dart';
import 'package:dollarax/modules/trade/cubit/active_trade/active_trade_cubit.dart';
import 'package:dollarax/modules/trade/cubit/end_trade/end_trade_cubit.dart';
import 'package:dollarax/modules/trade/cubit/end_trade/end_trade_state.dart';
import 'package:dollarax/modules/trade/cubit/latest_trades/latest_trades_cubit.dart';
import 'package:dollarax/modules/trade/cubit/start_trade/start_trade_cubit.dart';
import 'package:dollarax/modules/trade/cubit/start_trade/start_trade_state.dart';
import 'package:dollarax/modules/trade/cubit/take_profit_stop_loss/trade_tpsl_cubit.dart';
import 'package:dollarax/modules/trade/models/btc_to_usdt_input.dart';
import 'package:dollarax/modules/trade/models/btc_to_usdt_rate_response.dart';
import 'package:dollarax/modules/trade/models/gold_data_model.dart';
import 'package:dollarax/modules/trade/widgets/candle_chart_widget.dart';
import 'package:dollarax/modules/trade/widgets/latest_trades_widget.dart';
import 'package:dollarax/modules/trade/widgets/trade_start_end_widget.dart';
import 'package:dollarax/modules/trade/widgets/trade_tpsl_widget.dart';
import 'package:dollarax/ui/widgets/custom_appbar.dart';
import 'package:dollarax/utils/custom_date_time_picker.dart';
import 'package:dollarax/utils/display/display_utils.dart';
import 'package:dollarax/utils/extensions/extended_context.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;

import '../../../ui/widgets/toast_loader.dart';

class FutureTradePage extends StatefulWidget {
  const FutureTradePage({super.key});

  @override
  State<FutureTradePage> createState() => _FutureTradePageState();
}

class _FutureTradePageState extends State<FutureTradePage> {
  List<Candle> candles = [];
  bool themeIsDark = false;
  late Timer _candleApiTimer;
  bool isAmountFetched = true;
  String tradeBtcRate = '0.0';
  late Timer _timer;
  late Timer _activeApiTimer;
  BtcToUsdtRateResponse? apiResponse;

  List<String> timeList = [
    'Time',
    '1s',
    '1m',
    '5m',
    '30m',
    '1h',
    '1d',
    '1w',
    '1M',
  ];
  String selectedTime = '1s';

  Future<List<Candle>> fetchCandles(String interval) async {
    final uri = Uri.parse(
        "https://api.binance.com/api/v3/klines?symbol=BTCUSDT&interval=${interval}");
    final res = await http.get(uri);
    return (jsonDecode(res.body) as List<dynamic>)
        .map((e) => Candle.fromJson(e))
        .toList()
        .reversed
        .toList();
  }
Future<List<GoldDataModel>> fetchGoldDataCandles() async {
    final uri = Uri.parse(
        "https://api.tiingo.com/tiingo/fx/xauusd/prices?startDate=${changeDateTimeFormat1(DateTime.now(), "yyyy-MM-dd")}&resampleFreq=1Min&token=827dc35ac4d85f807692bbe08309b66dc97e04ab");
    final res = await http.get(uri);
    if(res.statusCode == 200) {
      return (jsonDecode(res.body) as List<dynamic>)
          .map((e) => GoldDataModel.fromJson(e))
          .toList()
          .reversed
          .toList();
    }else{
      return [];
    }
  }

  @override
  void initState() {
    super.initState();
    _candleApiTimer = Timer.periodic(Duration(seconds: 2), (Timer timer) {
      // fetchCandles('1d').then((value) {
      //   setState(() {
      //     candles = value;
      //   });
      // });
      fetchGoldDataCandles().then((value) {
        if(value.isNotEmpty){
          setState(() {
            List<Candle> list = value.map((e) => Candle(date: e.date, high: e.high, low: e.low, open: e.open, close: e.close, volume: 0.05230000)).toList();
            candles = list;
          });
        }
      });
    });
    _timer = Timer.periodic(Duration(seconds: 2), (Timer timer) {
      fetchGoldDataCandles();
    });
    _activeApiTimer = Timer.periodic(Duration(seconds: 30), (Timer timer) {
      print('api call starting...');
      context.read<ActiveTradeCubit>()..activeTradeData(isLoading: false);
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    _activeApiTimer.cancel();
    _candleApiTimer.cancel();
    super.dispose();
  }

  Future<void> _makeApiCall() async {
    final response = await http.get(Uri.parse(
        'https://api.binance.com/api/v3/ticker/price?symbol=BTCUSDT'));

    if (response.statusCode == 200) {
      Map<String, dynamic> data = jsonDecode(response.body);
      apiResponse = BtcToUsdtRateResponse.fromJson(data);
      if (isAmountFetched) {
        isAmountFetched = false;
        if (apiResponse != null) {
          tradeBtcRate = roundTwoDecimal(apiResponse!.price.toString());
        }
      }
      setState(() {});
    } else {
      print('Failed to fetch data. Error code: ${response.statusCode}');
    }
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
        BlocProvider(
          create: (context) => BtcToUsdtCubit(sl())
            ..btcToUsdtData(BtcToUsdtInput(interval: '1s', limit: 200)),
        ),
      ],
      child: Scaffold(
        appBar: CustomAppbar(
          title: "Trade",
          backArrow: false,
        ),
        backgroundColor: Colors.black,
        body: BlocConsumer<EndTradeCubit, EndTradeState>(
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
                          "BTC-DAX",
                          style: context.textTheme.titleLarge,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16),
                        child: Text(
                          "+2.61%",
                          style: context.textTheme.bodySmall?.copyWith(
                              color: AppColors.primaryGreen, fontSize: 10),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                                child: LatestTradesWidget(
                              latestBtcRate: apiResponse != null
                                  ? roundTwoDecimal(apiResponse!.price)
                                  : "",
                            )),
                            SizedBox(
                              width: 8,
                            ),
                            Expanded(
                              child: TradeStartEndWidget(
                                tradeBtcRate: tradeBtcRate,
                              ),
                            )
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      TradeTPSLWidget(
                          tradeBtcRate:
                              apiResponse != null ? apiResponse!.price : ''),
                      Divider(
                        color: Colors.white,
                        thickness: .5,
                      ),
                      // Container(
                      //   height: 300,
                      //   color: Theme.of(context).backgroundColor,
                      //   child: Candlesticks(
                      //     candles: candles,
                      //   ),
                      // )
                      CandleChartWidget(candles: candles, onSelectedTime: (String interval) {
                        // fet(interval);
                      },)
                    ],
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
