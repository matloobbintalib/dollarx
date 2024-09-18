import 'dart:async';
import 'dart:convert';

import 'package:dollarax/constants/app_colors.dart';
import 'package:dollarax/modules/trade/cubit/end_trade/end_trade_cubit.dart';
import 'package:dollarax/modules/trade/cubit/latest_trades/latest_trades_cubit.dart';
import 'package:dollarax/modules/trade/cubit/latest_trades/latest_trades_state.dart';
import 'package:dollarax/modules/trade/cubit/start_trade/start_trade_cubit.dart';
import 'package:dollarax/modules/trade/models/btc_to_usdt_rate_response.dart';
import 'package:dollarax/modules/trade/models/buy_sell_input.dart';
import 'package:dollarax/ui/input/input_field.dart';
import 'package:dollarax/ui/widgets/custom_dropdown.dart';
import 'package:dollarax/ui/widgets/custom_radio_button.dart';
import 'package:dollarax/ui/widgets/empty_widget.dart';
import 'package:dollarax/ui/widgets/on_click.dart';
import 'package:dollarax/ui/widgets/primary_button.dart';
import 'package:dollarax/utils/custom_date_time_picker.dart';
import 'package:dollarax/utils/display/display_utils.dart';
import 'package:dollarax/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;

class StartTradeWidget extends StatefulWidget {
  final bool isTradeStarted;
  final String tradeBtcRate;
  const StartTradeWidget({super.key, required this.isTradeStarted, required this.tradeBtcRate});

  @override
  State<StartTradeWidget> createState() => _StartTradeWidgetState();
}

class _StartTradeWidgetState extends State<StartTradeWidget> {
  TextEditingController amountTextController = TextEditingController();
  TextEditingController currentValueTextController = TextEditingController();
  TextEditingController takeProfitController = TextEditingController();
  TextEditingController stopLossController = TextEditingController();
  String? limitType;
  double _limitCounter = 0;
  double _amountCounter = 0;
  bool selectedValue = false;
  BtcToUsdtRateResponse? apiResponse;
  bool isCurrentRateSet = true;

  @override
  void initState() {
    super.initState();
    amountTextController.text = _amountCounter.toString();
    _limitCounter = double.parse(widget.tradeBtcRate);
    currentValueTextController.text = widget.tradeBtcRate;
  }

  void _incrementCounter() {
    setState(() {
      _amountCounter++;
      amountTextController.text = _amountCounter.toString();
    });
  }

  void _decrementCounter() {
    setState(() {
      if (_amountCounter > 0) {
        _amountCounter--;
        amountTextController.text = _amountCounter.toString();
      }
    });
  }

  void _incrementLimitCounter() {
    setState(() {
      _limitCounter++;
      currentValueTextController.text = _limitCounter.toString();
    });
  }

  void _decrementLimitCounter() {
    setState(() {
      if (_limitCounter > 0) {
        _limitCounter--;
        currentValueTextController.text = _limitCounter.toString();
      }
    });
  }

  void sellTradeButton() {
    if (amountTextController.text.trim().isNotEmpty) {
      if (limitType != null) {
        context.read<StartTradeCubit>()
          ..startNewSellTrade(BuySellInput(
              amount: amountTextController.text.trim(),
              limit_value:
                  limitType.toString() == "Limit" ? 'limit' : 'current_rate',
              limit_btcrate: currentValueTextController.text.trim(),
              trade_take_profit:
                  selectedValue ? takeProfitController.text.trim() : null,
              trade_stop_loss:
                  selectedValue ? stopLossController.text.trim() : null));
      } else {
        context.read<StartTradeCubit>()
          ..startNewSellTrade(BuySellInput(
              amount: amountTextController.text.trim(),
              trade_take_profit:
                  selectedValue ? takeProfitController.text.trim() : null,
              trade_stop_loss:
                  selectedValue ? stopLossController.text.trim() : null));
      }
      takeProfitController.text = '';
      stopLossController.text = '';
    } else {
      DisplayUtils.showToast(context, 'Please add amount!');
    }
  }

  void buyTradeButton() {
    if (amountTextController.text.trim().isNotEmpty) {
      if (limitType != null) {
        context.read<StartTradeCubit>()
          ..startNewBuyTrade(BuySellInput(
              amount: amountTextController.text.trim(),
              limit_value:
                  limitType.toString() == "Limit" ? 'limit' : 'current_rate',
              limit_btcrate: currentValueTextController.text.trim(),
              trade_take_profit:
                  selectedValue ? takeProfitController.text.trim() : null,
              trade_stop_loss:
                  selectedValue ? stopLossController.text.trim() : null));
      } else {
        context.read<StartTradeCubit>()
          ..startNewBuyTrade(BuySellInput(
              amount: amountTextController.text.trim(),
              trade_take_profit:
                  selectedValue ? takeProfitController.text.trim() : null,
              trade_stop_loss:
                  selectedValue ? stopLossController.text.trim() : null));
      }
      takeProfitController.text = '';
      stopLossController.text = '';
    } else {
      DisplayUtils.showToast(context, 'Please add amount!');
    }
  }

  Future<void> makeApiCall() async {
    final response = await http.get(Uri.parse(
        'https://api.binance.com/api/v3/ticker/price?symbol=BTCUSDT'));

    if (response.statusCode == 200) {
      Map<String, dynamic> data = jsonDecode(response.body);
      apiResponse = BtcToUsdtRateResponse.fromJson(data);
      if (apiResponse != null) {
        currentValueTextController.text = roundTwoDecimal(apiResponse!.price);
        _limitCounter = double.parse(apiResponse!.price);
      }
      setState(() {});
    } else {
      print('Failed to fetch data. Error code: ${response.statusCode}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Row(
            children: [
              Text('Avbl',
                  style: context.textTheme.bodySmall
                      ?.copyWith(fontWeight: FontWeight.w300, fontSize: 10)),
              Spacer(),
              BlocBuilder<LatestTradeCubit, LatestTradeState>(
                builder: (context, latestTradeState) {
                  if (latestTradeState.latestTradeStatus ==
                      LatestTradeStatus.success) {
                    return Text('${latestTradeState.tradeBalance} USD',
                        style: context.textTheme.bodySmall?.copyWith(
                            fontWeight: FontWeight.w600,
                            fontSize: 10,
                            color: AppColors.secondary));
                  }
                  return EmptyWidget();
                },
              ),
              SizedBox(
                width: 2,
              ),
              Image.asset(
                "assets/images/png/ic_exchange.png",
                height: 14,
                width: 14,
              )
            ],
          ),
          SizedBox(
            height: 6,
          ),
          CustomDropDown(
              horizontalPadding: 14,
              verticalPadding: 3,
              hint: 'Limit',
              suffixIconSize: 9,
              fontSize: 10,
              onSelect: (value) {
                setState(() {
                  limitType = value;
                });
              },
              items: ['Limit', 'Market Current Execution']),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 8),
            child: Row(
              children: [
                OnClick(
                    onTap: () {
                      _decrementLimitCounter();
                    },
                    child: Icon(
                      Icons.remove,
                      color: Colors.white,
                      size: 18,
                    )),
                Expanded(
                    child: Column(
                      children: [
                        Text('Price (USD)',
                            style: context.textTheme.bodySmall?.copyWith(
                                fontWeight: FontWeight.w300, fontSize: 10)),
                        // BlocBuilder<LatestTradeCubit, LatestTradeState>(
                        //   builder: (context, latestTradeState) {
                        //     if (latestTradeState.latestTradeStatus ==
                        //         LatestTradeStatus.success) {
                        //       if(isCurrentRateSet){
                        //         isCurrentRateSet = false;
                        //         if(latestTradeState.goldRate !=  null){
                        //           _limitCounter = latestTradeState.goldRate;
                        //           currentValueTextController.text = latestTradeState.goldRate.toString();
                        //         }
                        //       }
                        //     }
                        //     return EmptyWidget();
                        //   },
                        // ),
                        InputField(
                            controller: currentValueTextController,
                            label: '0.0',
                            maxLines: 1,
                            textAlign: TextAlign.center,
                            vPadding: 0,
                            onChange: (value) {
                              _limitCounter = double.parse(value);
                              setState(() {});
                            },
                            keyboardType: TextInputType.number,
                            borderColor: AppColors.fieldColor,
                            textInputAction: TextInputAction.done)
                      ],
                      mainAxisAlignment: MainAxisAlignment.center,
                    )),
                OnClick(
                    onTap: () {
                      _incrementLimitCounter();
                    },
                    child: Icon(
                      Icons.add,
                      color: Colors.white,
                      size: 18,
                    )),
              ],
            ),
            height: 44,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(4),
                color: AppColors.fieldColor),
          ),
          SizedBox(
            height: 8,
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 8),
            child: Row(
              children: [
                OnClick(
                    onTap: () {
                      _decrementCounter();
                    },
                    child: Icon(
                      Icons.remove,
                      color: Colors.white,
                      size: 18,
                    )),
                Expanded(
                    child: InputField(
                        controller: amountTextController,
                        label: 'Amount',
                        maxLines: 1,
                        textAlign: TextAlign.center,
                        vPadding: 0,
                        onChange: (value) {
                          _amountCounter = double.parse(value);
                          setState(() {});
                        },
                        keyboardType: TextInputType.number,
                        borderColor: AppColors.fieldColor,
                        textInputAction: TextInputAction.done)),
                OnClick(
                    onTap: () {
                      _incrementCounter();
                    },
                    child: Icon(
                      Icons.add,
                      color: Colors.white,
                      size: 18,
                    )),
              ],
            ),
            height: 30,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(4),
                color: AppColors.fieldColor),
          ),
          SizedBox(
            height: 10,
          ),
          CustomRadioButtonWidget(
            title: 'TP/SL',
            fontSize: 10,
            checkBoxSize: 12,
            onChange: (value) {
              selectedValue = value;
              setState(() {});
            },
          ),
          Visibility(
              visible: selectedValue,
              child: Column(
                children: [
                  SizedBox(
                    height: 6,
                  ),
                  InputField(
                      controller: takeProfitController,
                      label: 'Take Profit',
                      keyboardType: TextInputType.number,
                      vPadding: 10,
                      borderRadius: 4,
                      fillColor: AppColors.fieldColor,
                      borderColor: AppColors.fieldColor,
                      textInputAction: TextInputAction.done),
                  SizedBox(
                    height: 6,
                  ),
                  InputField(
                      controller: stopLossController,
                      label: 'Stop Loss',
                      keyboardType: TextInputType.number,
                      vPadding: 10,
                      borderRadius: 4,
                      fillColor: AppColors.fieldColor,
                      borderColor: AppColors.fieldColor,
                      textInputAction: TextInputAction.done),
                ],
              )),
          SizedBox(
            height: 20,
          ),
          Visibility(
              visible: widget.isTradeStarted,
              child: Column(
                children: [
                  PrimaryButton(
                    onPressed: () {
                      buyTradeButton();
                    },
                    title: 'Buy / Long',
                    backgroundColor: AppColors.primaryGreen,
                    fontSize: 12,
                    height: 30,
                    borderColor: AppColors.primaryGreen,
                    titleColor: Colors.white,
                    fontWeight: FontWeight.w400,
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  PrimaryButton(
                    onPressed: () {
                      sellTradeButton();
                    },
                    title: 'Sell/ Short',
                    backgroundColor: AppColors.lightRed,
                    fontSize: 12,
                    height: 30,
                    borderColor: AppColors.lightRed,
                    titleColor: Colors.white,
                    fontWeight: FontWeight.w400,
                  )
                ],
              )),
          Visibility(
              visible: !widget.isTradeStarted,
              child: PrimaryButton(
                onPressed: () {
                  context.read<EndTradeCubit>()..endCurrentTrade();
                },
                title: 'End Trade',
                backgroundColor: AppColors.lightRed,
                fontSize: 12,
                height: 26,
                borderColor: AppColors.lightRed,
                titleColor: Colors.white,
                fontWeight: FontWeight.w400,
              ))
        ],
      ),
    );
  }
}
