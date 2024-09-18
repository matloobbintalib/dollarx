import 'package:dollarax/config/routes/nav_router.dart';
import 'package:dollarax/constants/app_colors.dart';
import 'package:dollarax/core/di/service_locator.dart';
import 'package:dollarax/modules/exchange/cubit/exchange_cubit.dart';
import 'package:dollarax/modules/exchange/cubit/exchange_state.dart';
import 'package:dollarax/modules/exchange/models/exchange_input.dart';
import 'package:dollarax/modules/investment/widgets/investment_widget.dart';
import 'package:dollarax/modules/kyc_verification/cubit/country_list/country_list_cubit.dart';
import 'package:dollarax/modules/kyc_verification/cubit/country_list/country_list_state.dart';
import 'package:dollarax/modules/kyc_verification/models/country_list_response.dart';
import 'package:dollarax/modules/wallet/models/wallet_details_response.dart';
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

class ExchangePage extends StatefulWidget {
  final List<CurrencyModel> currenciesList;
  final String totalBalanceUsd;

  const ExchangePage({super.key, required this.currenciesList, required this.totalBalanceUsd});

  @override
  State<ExchangePage> createState() => _ExchangePageState();
}

class _ExchangePageState extends State<ExchangePage> {
  String? currencyName;
  String? exchangeType;
  TextEditingController amountController = TextEditingController();
  List<String> exchangeTypeList = ['BUY USD', 'SELL USD'];
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ExchangeCubit(sl()),
      child: Scaffold(
        appBar: CustomAppbar(
          title: "Exchange",
        ),
        backgroundColor: AppColors.black,
        body: BlocConsumer<ExchangeCubit, ExchangeState>(
          listener: (context, state) {
            if (state.exchangeStatus == ExchangeStatus.loading) {
              ToastLoader.show();
            } else if (state.exchangeStatus == ExchangeStatus.success) {
              ToastLoader.remove();
              DisplayUtils.showToast(context, state.message);
              NavRouter.pop(context);
            } else if (state.exchangeStatus == ExchangeStatus.failure) {
              ToastLoader.remove();
              DisplayUtils.showToast(context, state.message);
            }
          },
          builder: (context, state) {
            return Form(
              key:formKey,
              child: SingleChildScrollView(
                padding: EdgeInsets.all(12),
                child: Column(
                  children: [
                    SizedBox(height: 40,),
                    Text(
                      'fast & secure way to Exchange cryptocurrencies',
                      style: context.textTheme.bodySmall
                          ?.copyWith(fontWeight: FontWeight.w500),
                    ),
                    SizedBox(height: 16,),
                    Text(
                      'Available Balance \$${widget.totalBalanceUsd}',
                      style: context.textTheme.bodyLarge
                          ?.copyWith(fontWeight: FontWeight.w500),
                    ),
                    SizedBox(height: 30,),
                    Align(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        child: Text(
                          "Exchange Type",
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
                      hint: exchangeType != null
                          ? exchangeType.toString()
                          : "Exchange Type",
                      items: exchangeTypeList
                          .toList(),
                      enable: true,
                      hintColor: AppColors.grey1,
                      suffixIconPath:
                      "assets/images/png/ic_drop_down_yellow.png",
                      onSelect: (value) {
                        if(value == 'BUY USD'){
                          exchangeType = 'buy';
                        }else if(value == 'SELL USD'){
                          exchangeType = 'sell';
                        }
                      },
                    ),
                    SizedBox(height: 10,),
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
                      items: widget.currenciesList
                          .map((e) => e.currency)
                          .toList(),
                      enable: true,
                      hintColor: AppColors.grey1,
                      suffixIconPath:
                      "assets/images/png/ic_drop_down_yellow.png",
                      onSelect: (value) {
                        CurrencyModel currencyModel = widget.currenciesList
                            .firstWhere((element) => element.currency == value);
                        currencyName = currencyModel.currency;
                      },
                    ),
                    SizedBox(height: 10,),
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
                    SizedBox(height: 70,),
                    PrimaryButton(onPressed: () {
                      if (formKey.currentState!.validate()) {
                        if(exchangeType != null){
                          if (currencyName != null) {
                            context.read<ExchangeCubit>()..buySellCoins(
                                ExchangeInput(
                                    amount: amountController.text.trim(),
                                    currency: currencyName.toString(),
                                    exchange_type: exchangeType.toString()));
                          } else {
                            DisplayUtils.showToast(context, 'Select your currency');
                          }
                        }else{
                          DisplayUtils.showToast(context, 'Select exchange type');
                        }
                      }
                    }, title: 'Exchange Now')
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
