import 'package:dollarax/config/config.dart';
import 'package:dollarax/constants/app_colors.dart';
import 'package:dollarax/core/di/service_locator.dart';
import 'package:dollarax/modules/home/cubit/dashboard_refresh_cubit.dart';
import 'package:dollarax/modules/home/cubit/dashboard_refresh_state.dart';
import 'package:dollarax/modules/islamic_trade/cubit/start_islamic_trade/start_islamic_trade_cubit.dart';
import 'package:dollarax/modules/islamic_trade/cubit/start_islamic_trade/start_islamic_trade_state.dart';
import 'package:dollarax/modules/islamic_trade/models/start_islamic_trade_input.dart';
import 'package:dollarax/ui/input/input_field.dart';
import 'package:dollarax/ui/widgets/custom_appbar.dart';
import 'package:dollarax/ui/widgets/custom_dropdown.dart';
import 'package:dollarax/ui/widgets/empty_widget.dart';
import 'package:dollarax/ui/widgets/loading_indicator.dart';
import 'package:dollarax/ui/widgets/primary_button.dart';
import 'package:dollarax/ui/widgets/toast_loader.dart';
import 'package:dollarax/utils/display/display_utils.dart';
import 'package:dollarax/utils/extensions/extended_context.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class StartIslamicTradePage extends StatefulWidget {
  final String tradeType;
  final int item_id;

  const StartIslamicTradePage({super.key, required this.tradeType, required this.item_id});

  @override
  State<StartIslamicTradePage> createState() => _StartIslamicTradePageState();
}

class _StartIslamicTradePageState extends State<StartIslamicTradePage> {
  String? currencyName;
  TextEditingController amountController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  List<String> currenciesList = ['USD', 'BTC', 'ETH'];

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => StartIslamicTradeCubit(sl()),
        ),
        BlocProvider(
          create: (context) => DashBoardRefreshCubit(sl())..dashBoardRefresh(),
        ),
      ],
      child: Scaffold(
        appBar: CustomAppbar(
          title: "Start Copy Trade Page",
        ),
        backgroundColor: AppColors.black,
        body: BlocBuilder<DashBoardRefreshCubit, DashBoardRefreshState>(
          builder: (context, dashboardState) {
            if (dashboardState.dashBoardStatus ==
                DashBoardRefreshStatus.loading) {
              return Center(
                child: LoadingIndicator(),
              );
            }
            if (dashboardState.dashBoardStatus ==
                DashBoardRefreshStatus.error) {
              return Center(
                child: Text(dashboardState.message),
              );
            }
            if (dashboardState.dashBoardStatus ==
                DashBoardRefreshStatus.success) {
              return Form(
                key: formKey,
                child: SingleChildScrollView(
                  padding: EdgeInsets.all(12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: 20,
                      ),
                      Text(
                        'Available Balance',
                        style: context.textTheme.bodyLarge
                            ?.copyWith(fontWeight: FontWeight.w500),
                      ),
                      SizedBox(height: 16,),
                      Text(
                        'USD Balance : ${dashboardState.dashboardModel!.walletBalanceAllCurrencies.usdt}',
                        style: context.textTheme.bodyMedium
                            ?.copyWith(fontWeight: FontWeight.w400),
                      ),
                      Text(
                        'BTC Balance : ${dashboardState.dashboardModel!.walletBalanceAllCurrencies.btc}',
                        style: context.textTheme.bodyMedium
                            ?.copyWith(fontWeight: FontWeight.w400),
                      ),
                      Text(
                        'ETH Balance : ${dashboardState.dashboardModel!.walletBalanceAllCurrencies.eth}',
                        style: context.textTheme.bodyMedium
                            ?.copyWith(fontWeight: FontWeight.w400),
                      ),
                      SizedBox(
                        height: 24,
                      ),
                      SizedBox(
                        height: 24,
                      ),
                      Align(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8),
                          child: Text(
                            "Currency",
                            style: context.textTheme.bodyMedium,
                            textAlign: TextAlign.start,
                          ),
                        ),
                        alignment: Alignment.centerLeft,
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      CustomDropDown(
                        hint: currencyName != null
                            ? currencyName.toString()
                            : "Select Your Currency",
                        items: currenciesList,
                        enable: true,
                        hintColor: AppColors.grey1,
                        suffixIconPath:
                            "assets/images/png/ic_drop_down_yellow.png",
                        onSelect: (value) {
                          if(value.toString() == 'USD') {
                            currencyName = 'USDT';
                        }else{
                            currencyName = value;
                          }
                        },
                      ),
                      SizedBox(
                        height: 16,
                      ),
                      Align(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8),
                          child: Text(
                            "Enter Amount",
                            style: context.textTheme.bodyMedium,
                            textAlign: TextAlign.start,
                          ),
                        ),
                        alignment: Alignment.centerLeft,
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      InputField.number(
                        controller: amountController,
                        label: "Enter Amount",
                      ),
                      SizedBox(
                        height: 50,
                      ),
                      BlocConsumer<StartIslamicTradeCubit,
                          StartIslamicTradeState>(
                        listener: (context, state) {
                          if (state.startIslamicTradeStatus ==
                              StartIslamicTradeStatus.loading) {
                            ToastLoader.show();
                          } else if (state.startIslamicTradeStatus ==
                              StartIslamicTradeStatus.success) {
                            ToastLoader.remove();
                            DisplayUtils.showToast(context, state.message);
                            NavRouter.pop(context);
                          } else if (state.startIslamicTradeStatus ==
                              StartIslamicTradeStatus.error) {
                            ToastLoader.remove();
                            DisplayUtils.showToast(context, state.message);
                          }
                        },
                        builder: (context, state) {
                          return PrimaryButton(
                              onPressed: () {
                                if (formKey.currentState!.validate()) {
                                  if (currencyName != null) {
                                    context.read<StartIslamicTradeCubit>()
                                      ..startIslamicTrade(
                                          StartIslamicTradeInput(
                                              amount:
                                                  amountController.text.trim(),
                                              currency: currencyName.toString(),
                                              trade_type: widget.tradeType,
                                            item_id: widget.item_id
                                          ));
                                  } else {
                                    DisplayUtils.showToast(
                                        context, 'Select your currency');
                                  }
                                }
                              },
                              title: 'Start Trade ');
                        },
                      ),
                    ],
                  ),
                ),
              );
            }
            return EmptyWidget();
          },
        ),
      ),
    );
  }
}
