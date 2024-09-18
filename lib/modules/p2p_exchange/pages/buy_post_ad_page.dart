import 'package:dollarax/config/routes/nav_router.dart';
import 'package:dollarax/constants/app_colors.dart';
import 'package:dollarax/core/di/service_locator.dart';
import 'package:dollarax/modules/p2p_exchange/cubits/buy_post_ad_cubit.dart';
import 'package:dollarax/modules/p2p_exchange/cubits/buy_post_ad_state.dart';
import 'package:dollarax/modules/p2p_exchange/cubits/countries_list/countries_list_cubit.dart';
import 'package:dollarax/modules/p2p_exchange/cubits/countries_list/countries_list_state.dart';
import 'package:dollarax/modules/p2p_exchange/cubits/exchange_rates/exchange_rates_cubit.dart';
import 'package:dollarax/modules/p2p_exchange/cubits/exchange_rates/exchange_rates_state.dart';
import 'package:dollarax/modules/p2p_exchange/cubits/save_exchange/save_exchange_cubit.dart';
import 'package:dollarax/modules/p2p_exchange/cubits/save_exchange/save_exchange_state.dart';
import 'package:dollarax/modules/p2p_exchange/models/save_exchange_input.dart';
import 'package:dollarax/modules/wallet/cubit/wallet_details_cubit.dart';
import 'package:dollarax/modules/wallet/cubit/wallet_details_state.dart';
import 'package:dollarax/ui/input/input_field.dart';
import 'package:dollarax/ui/widgets/custom_dropdown.dart';
import 'package:dollarax/ui/widgets/empty_widget.dart';
import 'package:dollarax/ui/widgets/loading_indicator.dart';
import 'package:dollarax/ui/widgets/primary_button.dart';
import 'package:dollarax/ui/widgets/toast_loader.dart';
import 'package:dollarax/utils/custom_date_time_picker.dart';
import 'package:dollarax/utils/display/display_utils.dart';
import 'package:dollarax/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shimmer/shimmer.dart';

class BuyPostAdPage extends StatefulWidget {
  const BuyPostAdPage({super.key});

  @override
  State<BuyPostAdPage> createState() => _BuyPostAdPageState();
}

class _BuyPostAdPageState extends State<BuyPostAdPage> {
  TextEditingController currentValueTextController = TextEditingController();
  TextEditingController amountController = new TextEditingController();
  TextEditingController totalAmountController = new TextEditingController();
  String totalAmount = '0';
  String toCurrencyName = '';
  String fromCurrencyName = '';
  String exchangeType = 'Buy';
  double _limitCounter = 0;
  bool isRateFetched = false;
  bool isToCurrencyApiCalled = false;
  bool isFromCurrencyApiCalled = false;
  String exchangeRate = '0';

  void _incrementLimitCounter() {
    _limitCounter++;
    context.read<BuyPostAdCubit>()..counterValueAmount(_limitCounter);
    currentValueTextController.text = _limitCounter.toString();
    if(amountController.text.trim().toString().isNotEmpty){
      var rate = double.parse(amountController.text.toString());
      context.read<BuyPostAdCubit>()
        ..changeTotalAmount(
          roundTwoDecimal((context.read<BuyPostAdCubit>().state.counterValue * rate)
                .toString()));
    }
  }

  void _decrementLimitCounter() {
    if (_limitCounter > 0) {
      _limitCounter--;
      context.read<BuyPostAdCubit>()..counterValueAmount(_limitCounter);
      currentValueTextController.text = _limitCounter.toString();
      if(amountController.text.trim().toString().isNotEmpty){
        var rate = double.parse(amountController.text.toString());
        context.read<BuyPostAdCubit>()
          ..changeTotalAmount(
            roundTwoDecimal((context.read<BuyPostAdCubit>().state.counterValue * rate)
                  .toString()));
      }
    }
  }

  @override
  void initState() {
    super.initState();
    context.read<BuyPostAdCubit>()..setCounterInitialValue();
  }

  @override
  Widget build(BuildContext context) {
    print('build call');
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => CountriesListCubit(sl()),
        ),
        BlocProvider(
          create: (context) => WalletDetailsCubit(sl())..walletDetailsData(),
        ),
        BlocProvider(
          create: (context) => ExchangeRateCubit(sl()),
        ),
        BlocProvider(
          create: (context) => SaveExchangeCubit(sl()),
        ),
      ],
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: AppColors.secondary,
          leading: IconButton(
            icon: Image.asset(
              "assets/images/png/ic_back_arrow.png",
              width: 26,
            ),
            onPressed: () {
              NavRouter.pop(context);
            },
          ),
          title: Text(
            'Buy Post Ad',
            style: context.textTheme.titleLarge
                ?.copyWith(color: Colors.black, fontWeight: FontWeight.w500),
            textAlign: TextAlign.center,
          ),
        ),
        backgroundColor: AppColors.black,
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(child:
                        BlocBuilder<WalletDetailsCubit, WalletDetailsState>(
                      builder: (context, walletState) {
                        if (walletState.walletDetailsStatus ==
                            WalletDetailsStatus.loading) {
                          return Shimmer.fromColors(
                              baseColor: Colors.grey[300]!,
                              highlightColor: Colors.grey[100]!,
                              child: CustomDropDown(
                                items: [],
                                height: 50,
                                hint: '',
                                borderColor: AppColors.secondary,
                                enable: true,
                              ));
                        }
                        if (walletState.walletDetailsStatus ==
                            WalletDetailsStatus.error) {
                          return Center(
                            child: Text(walletState.message),
                          );
                        }
                        if (walletState.walletDetailsStatus ==
                            WalletDetailsStatus.success) {
                          if (walletState
                              .walletModel!.currencyData.isNotEmpty) {
                            fromCurrencyName = walletState
                                .walletModel!.currencyData.first.currency;
                            context.read<CountriesListCubit>()
                              ..getAllCountries();
                          }
                          return CustomDropDown(
                            items: walletState.walletModel!.currencyData
                                .map((e) => e.currency)
                                .toList(),
                            height: 50,
                            hint: walletState
                                .walletModel!.currencyData.first.currency,
                            borderColor: AppColors.secondary,
                            onSelect: (value) {
                              fromCurrencyName = value;
                              context.read<ExchangeRateCubit>().getExchangeRate(
                                  fromCurrencyName, toCurrencyName, 'Buy');
                            },
                            enable: true,
                          );
                        }
                        return EmptyWidget();
                      },
                    )),
                    SizedBox(
                      width: 6,
                    ),
                    Expanded(child:
                        BlocBuilder<CountriesListCubit, CountriesListState>(
                      builder: (context, countriesState) {
                        if (countriesState.countriesListStatus ==
                            CountriesListStatus.loading) {
                          return Shimmer.fromColors(
                              baseColor: Colors.grey[300]!,
                              highlightColor: Colors.grey[100]!,
                              child: CustomDropDown(
                                items: [],
                                height: 50,
                                hint: '',
                                borderColor: AppColors.secondary,
                                enable: true,
                              ));
                        }
                        if (countriesState.countriesListStatus ==
                            CountriesListStatus.error) {
                          return Center(
                            child: Text(countriesState.message),
                          );
                        }
                        if (countriesState.countriesListStatus ==
                            CountriesListStatus.success) {
                          if (countriesState.countriesList.isNotEmpty) {
                            toCurrencyName =
                                countriesState.countriesList.first.currency;
                            if (fromCurrencyName.isNotEmpty &&
                                toCurrencyName.isNotEmpty) {
                              if (!isToCurrencyApiCalled) {
                                isToCurrencyApiCalled = true;
                                context
                                    .read<ExchangeRateCubit>()
                                    .getExchangeRate(fromCurrencyName,
                                        toCurrencyName, 'Buy');
                              }
                            }
                          }

                          return CustomDropDown(
                            items: countriesState.countriesList
                                .map((e) => e.currency)
                                .toList()
                                .toSet()
                                .toList(),
                            height: 50,
                            hint: countriesState.countriesList.first.currency,
                            onSelect: (value) {
                              if (value.isNotEmpty) {
                                toCurrencyName = value;
                                context
                                    .read<ExchangeRateCubit>()
                                    .getExchangeRate(fromCurrencyName,
                                        toCurrencyName, 'Buy');
                              }
                            },
                            borderColor: AppColors.secondary,
                            enable: true,
                          );
                        }
                        return EmptyWidget();
                      },
                    )),
                  ],
                ),
                SizedBox(
                  height: 40,
                ),
                BlocBuilder<ExchangeRateCubit, ExchangeRateState>(
                  builder: (context, exchangeRateState) {
                    if (exchangeRateState.exchangeRateStatus ==
                        ExchangeRateStatus.loading) {
                      return Center(
                        child: LoadingIndicator(),
                      );
                    }
                    if (exchangeRateState.exchangeRateStatus ==
                        ExchangeRateStatus.error) {
                      return Center(
                        child: Text(exchangeRateState.message),
                      );
                    }
                    if (exchangeRateState.exchangeRateStatus ==
                        ExchangeRateStatus.success) {
                      currentValueTextController.text = exchangeRateState.rate.exchangeRate
                          .replaceAll(',', '');
                      context.read<BuyPostAdCubit>()
                        ..counterValueAmount(double.parse(exchangeRateState
                            .rate.exchangeRate
                            .replaceAll(',', '')));
                      _limitCounter = double.parse(exchangeRateState
                          .rate.exchangeRate
                          .replaceAll(',', ''));
                      amountController.text = '0';
                      if (amountController.text.trim().isNotEmpty) {
                        var rate = double.parse(amountController.text);
                        var amount = double.parse(exchangeRateState
                            .rate.exchangeRate
                            .replaceAll(',', '')
                            .toString());
                        context.read<BuyPostAdCubit>()
                          ..changeTotalAmount(roundTwoDecimal((amount * rate).toString()));
                      }
                      exchangeRate = exchangeRateState.rate.exchangeRate
                          .replaceAll(',', '')
                          .toString();
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 4),
                            child: Text(
                              'Price Type',
                              style: context.textTheme.bodySmall?.copyWith(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 10,
                                  color: AppColors.hindColor),
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: 8),
                            child: Row(
                              children: [
                                IconButton(
                                    onPressed: () {
                                      _decrementLimitCounter();
                                    },
                                    icon: Icon(
                                      Icons.remove,
                                      color: Colors.white,
                                      size: 24,
                                    )),
                                Expanded(child:
                                    BlocBuilder<BuyPostAdCubit, BuyPostAdState>(
                                  builder: (context, buyPostAdState) {
                                    _limitCounter = buyPostAdState.counterValue;
                                    return InputField(
                                        controller: currentValueTextController,
                                        label: 'Amount',
                                        maxLines: 1,
                                        textAlign: TextAlign.center,
                                        fontSize: 16,
                                        onSaved: (value) {
                                          DisplayUtils.showToast(context, value.toString());
                                        },
                                        onChange: (value){
                                          if (value.isNotEmpty) {
                                            var amount = double.parse(value);
                                            var rate = double.parse(
                                                amountController.text
                                                    .toString());
                                            context.read<BuyPostAdCubit>()
                                              ..counterValueAmount(double.parse(value));
                                            context.read<BuyPostAdCubit>()
                                              ..changeTotalAmount(
                                                roundTwoDecimal((amount * rate).toString()));
                                          } else {
                                            context.read<BuyPostAdCubit>()
                                              ..changeTotalAmount(roundTwoDecimal('0'));
                                          }
                                        },
                                        keyboardType: TextInputType.numberWithOptions(
                                          decimal: true,
                                          signed: false,
                                        ),
                                        inputFormatters: [
                                          FilteringTextInputFormatter.allow(RegExp(r"[0-9.]")),
                                          TextInputFormatter.withFunction((oldValue, newValue) {
                                            final text = newValue.text;
                                            return text.isEmpty
                                                ? newValue
                                                : double.tryParse(text) == null
                                                ? oldValue
                                                : newValue;
                                          }),
                                        ],
                                        fontWeight: FontWeight.w400,
                                        borderColor: AppColors.fieldColor,
                                        textInputAction: TextInputAction.done);
                                  },
                                )),
                                IconButton(
                                    onPressed: () {
                                      _incrementLimitCounter();
                                    },
                                    icon: Icon(
                                      Icons.add,
                                      color: Colors.white,
                                      size: 24,
                                    )),
                              ],
                            ),
                            height: 50,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(4),
                                border: Border.all(color: AppColors.secondary),
                                color: AppColors.fieldColor),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 4),
                            child: Row(
                              children: [
                                Text(
                                  'Current Rate ',
                                  style: context.textTheme.bodySmall?.copyWith(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 10,
                                      color: AppColors.hindColor),
                                ),
                                Text(
                                  exchangeRateState.rate.exchangeRate
                                      .replaceAll(',', '')
                                      .toString(),
                                  style: context.textTheme.bodySmall?.copyWith(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 10),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 4),
                            child: Text(
                              'Total Amount',
                              style: context.textTheme.bodySmall?.copyWith(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 10,
                                  color: AppColors.hindColor),
                            ),
                          ),
                          Container(
                            height: 50,
                            padding: EdgeInsets.symmetric(horizontal: 12),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(4),
                                color: AppColors.fieldColor,
                                border: Border.all(color: AppColors.secondary)),
                            child: Row(
                              children: [
                                Expanded(
                                    child: InputField(
                                        controller: amountController,
                                        label: 'Enter Total Amount',
                                        fontSize: 14,
                                        keyboardType: TextInputType.number,
                                        hintColor: AppColors.hindColor,
                                        borderColor: AppColors.fieldColor,
                                        fontWeight: FontWeight.w700,
                                        onChange: (value) {
                                          if (value.isNotEmpty) {
                                            var amount = double.parse(value);
                                            print(amountController.text);
                                            var rate = double.parse(
                                                currentValueTextController.text
                                                    .toString());
                                            context.read<BuyPostAdCubit>()
                                              ..changeTotalAmount(
                                                  roundTwoDecimal((amount * rate).toString()));
                                          } else {
                                            context.read<BuyPostAdCubit>()
                                              ..changeTotalAmount(roundTwoDecimal('0'));
                                          }
                                        },
                                        textInputAction: TextInputAction.done)),
                                SizedBox(
                                  width: 8,
                                ),
                                Text(
                                  fromCurrencyName,
                                  style: context.textTheme.bodyLarge
                                      ?.copyWith(fontWeight: FontWeight.w400),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 4),
                            child: Text(
                              'Avbl ${exchangeRateState.rate.currenyBalance} ${fromCurrencyName}',
                              style: context.textTheme.bodySmall?.copyWith(
                                  fontWeight: FontWeight.w500,
                                  color: AppColors.hindColor),
                            ),
                          ),
                          SizedBox(
                            height: 50,
                          ),
                          BlocBuilder<BuyPostAdCubit, BuyPostAdState>(
                            builder: (context, buyPostAdState) {
                              totalAmountController.text =
                                  buyPostAdState.totalAmount;
                              return Container(
                                height: 50,
                                padding: EdgeInsets.symmetric(horizontal: 12),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(4),
                                    color: AppColors.fieldColor,
                                    border:
                                        Border.all(color: AppColors.secondary)),
                                child: Row(
                                  children: [
                                    Expanded(
                                        child: InputField(
                                            controller: totalAmountController,
                                            label: '0',
                                            fontSize: 14,
                                            readOnly: true,
                                            hintColor: AppColors.hindColor,
                                            borderColor: AppColors.fieldColor,
                                            fontWeight: FontWeight.w700,
                                            textInputAction:
                                                TextInputAction.done)),
                                    SizedBox(
                                      width: 8,
                                    ),
                                    Text(
                                      toCurrencyName,
                                      style: context.textTheme.bodyLarge
                                          ?.copyWith(
                                              fontWeight: FontWeight.w400),
                                    ),
                                  ],
                                ),
                              );
                            },
                          ),
                          SizedBox(
                            height: 40,
                          ),
                          BlocConsumer<SaveExchangeCubit, SaveExchangeState>(
                            listener: (context, saveExchangeState) {
                              if (saveExchangeState.saveExchangeStatus ==
                                  SaveExchangeStatus.loading) {
                                ToastLoader.show();
                              }
                              if (saveExchangeState.saveExchangeStatus ==
                                  SaveExchangeStatus.success) {
                                ToastLoader.remove();
                                DisplayUtils.showToast(context, saveExchangeState.message);
                                NavRouter.pop(context);
                              }
                              if (saveExchangeState.saveExchangeStatus ==
                                  SaveExchangeStatus.error) {
                                ToastLoader.remove();
                                DisplayUtils.showToast(
                                    context, saveExchangeState.message);
                              }
                            },
                            builder: (context, state) {
                              return PrimaryButton(
                                  onPressed: () {
                                    if (amountController.text
                                        .trim()
                                        .isNotEmpty) {
                                      context
                                          .read<SaveExchangeCubit>()
                                          .saveExchange(SaveExchangeInput(
                                              sell_amount: amountController.text
                                                  .trim()
                                                  .toString(),
                                              sell_currency: fromCurrencyName,
                                              buy_currency: toCurrencyName,
                                              p2p_type: exchangeType,
                                              currency_rate:
                                                  currentValueTextController
                                                      .text
                                                      .trim()
                                                      .toString(),
                                              total_amount:
                                                  totalAmountController.text
                                                      .trim()
                                                      .trim()));
                                    } else {
                                      DisplayUtils.showToast(
                                          context, 'Enter Total Amount');
                                    }
                                  },
                                  title: 'Done');
                            },
                          )
                        ],
                      );
                    }
                    return EmptyWidget();
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
