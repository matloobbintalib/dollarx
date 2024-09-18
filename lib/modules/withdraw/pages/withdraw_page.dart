import 'package:dollarax/constants/app_colors.dart';
import 'package:dollarax/modules/withdraw/cubit/withdraw_data/withdraw_data_cubit.dart';
import 'package:dollarax/modules/withdraw/cubit/withdraw_data/withdraw_data_state.dart';
import 'package:dollarax/modules/withdraw/cubit/withdraw_save/withdraw_save_cubit.dart';
import 'package:dollarax/modules/withdraw/cubit/withdraw_save/withdraw_save_state.dart';
import 'package:dollarax/modules/withdraw/models/withdraw_input.dart';
import 'package:dollarax/ui/widgets/base_scaffold.dart';
import 'package:dollarax/ui/widgets/custom_appbar.dart';
import 'package:dollarax/ui/widgets/custom_dropdown.dart';
import 'package:dollarax/ui/widgets/empty_widget.dart';
import 'package:dollarax/ui/widgets/loading_indicator.dart';
import 'package:dollarax/utils/display/display_utils.dart';
import 'package:dollarax/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../config/routes/nav_router.dart';
import '../../../core/di/service_locator.dart';
import '../../../ui/input/input_field.dart';
import '../../../ui/widgets/primary_button.dart';
import '../../../ui/widgets/toast_loader.dart';
import '../../deposit/widgets/deposit_widget.dart';

class WithdrawPage extends StatefulWidget {
  const WithdrawPage({super.key});

  @override
  State<WithdrawPage> createState() => _WithdrawPageState();
}

class _WithdrawPageState extends State<WithdrawPage> {
  TextEditingController amountController = TextEditingController();
  TextEditingController transactionIdController = TextEditingController();
  TextEditingController walletAddressController = TextEditingController();

  String? currency;
  String? withdrawType;
  List<String> withdrawTypeList = [];

  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => WithdrawDataCubit(sl())..withdrawData(),
        ),
        BlocProvider(
          create: (context) => WithdrawSaveCubit(sl()),
        ),
      ],
      child: BaseScaffold(
          appBar: CustomAppbar(
            title: "Withdraw",
          ),
          safeAreaTop: true,
          body: BlocBuilder<WithdrawDataCubit, WithdrawDataState>(
            builder: (context, state) {
              if (state.withdrawDataStatus == WithdrawDataStatus.loading) {
                return Center(
                  child: LoadingIndicator(),
                );
              }
              if (state.withdrawDataStatus == WithdrawDataStatus.success) {
                withdrawTypeList.clear();
                withdrawTypeList.add(state.withdrawModel!.withdrawTypes.balance);
                withdrawTypeList.add(state.withdrawModel!.withdrawTypes.bonus);
                withdrawTypeList.add(state.withdrawModel!.withdrawTypes.profit);
                return RefreshIndicator(
                  onRefresh: (){
                    return Future.delayed(
                      Duration(seconds: 1),
                          () {
                        context.read<WithdrawDataCubit>().withdrawData();
                      },
                    );
                  },
                  child: SingleChildScrollView(
                      child: Form(
                        key: formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 20,
                        ),
                        DepositWidget(
                            iconPath: "assets/images/png/ic_usdt.png",
                            title: "USDT Withdrawals",
                            price:
                                "\$ ${state.withdrawModel!.usdtWithdrawBalance}"),
                        DepositWidget(
                            iconPath: "assets/images/png/ic_bitcoin_yellow.png",
                            title: "BTC Withdrawals",
                            price:'${state.withdrawModel!.btcWithdrawBalance} BTC'),
                        DepositWidget(
                            iconPath: "assets/images/png/ic_eth.png",
                            title: "ETH Withdrawals",
                            price:
                                '${state.withdrawModel!.ethWithdrawBalance} ETH'),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          "Available amount for Withdraw",
                          style: context.textTheme.bodySmall?.copyWith(
                              fontWeight: FontWeight.w300, fontSize: 11),
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        DepositWidget(
                            iconPath: "assets/images/png/ic_usdt.png",
                            title: "Wallet Balance USDT",
                            price: state.withdrawModel!.balanceUsdt != null?
                            '${state.withdrawModel!.balanceUsdt} USDT': "0.0 USDT"),
                        DepositWidget(
                            iconPath: "assets/images/png/ic_bitcoin_yellow.png",
                            title: "Wallet Balance BTC",
                            price: state.withdrawModel!.balanceBtc != null?
                            '${state.withdrawModel!.balanceBtc} BTC': "0.0 BTC"),
                        DepositWidget(
                            iconPath: "assets/images/png/ic_eth.png",
                            title: "Wallet Balance ETH",
                            price: state.withdrawModel!.balanceEth != null?
                            '${state.withdrawModel!.balanceEth} ETH': "0.0 ETH"),
                        DepositWidget(
                            iconPath: "assets/images/png/ic_available_bonus.png",
                            title: "Available Bonus",
                            price: state.withdrawModel!.bonusBalance != null?
                            '${state.withdrawModel!.bonusBalance} USDT': "0.0 USDT"),
                        DepositWidget(
                            iconPath: "assets/images/png/ic_available_profit.png",
                            title: "Available Profit",
                            price: state.withdrawModel!.profitBalance != null ?
                            '${state.withdrawModel!.profitBalance} USDT':"0.0 USDT"),
                        SizedBox(
                          height: 30,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Create New ",
                              style: context.textTheme.bodyLarge?.copyWith(
                                  fontWeight: FontWeight.w400, fontSize: 20),
                            ),
                            Text(
                              "Withdraw",
                              style: context.textTheme.bodyLarge?.copyWith(
                                  fontWeight: FontWeight.w400,
                                  color: AppColors.secondary,
                                  fontSize: 20),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 16,
                        ),
                        Align(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 8),
                            child: Text(
                              "Withdrawal Type",
                              style: context.textTheme.bodySmall,
                              textAlign: TextAlign.start,
                            ),
                          ),
                          alignment: Alignment.centerLeft,
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        CustomDropDown(
                          hint: "Withdrawal Type",
                          items: withdrawTypeList
                              .map((e) => e)
                              .toList(),
                          enable: true,
                          hintColor: AppColors.grey1,
                          suffixIconPath:
                              "assets/images/png/ic_drop_down_yellow.png",
                          onSelect: (value){
                            setState(() {
                              withdrawType = value;
                            });
                          },
                        ),
                        SizedBox(
                          height: 16,
                        ),
                        Align(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 8),
                            child: Text(
                              "Currency",
                              style: context.textTheme.bodySmall,
                              textAlign: TextAlign.start,
                            ),
                          ),
                          alignment: Alignment.centerLeft,
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        CustomDropDown(
                          hint: "Select Currency",
                          items: state.withdrawModel!.currencies
                              .map((e) => e.name)
                              .toList(),
                          enable: true,
                          hintColor: AppColors.grey1,
                          suffixIconPath:
                              "assets/images/png/ic_drop_down_yellow.png",
                          onSelect: (value) {
                            setState(() {
                              currency = value;
                            });
                          },
                        ),
                        SizedBox(
                          height: 16,
                        ),
                        Align(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 8),
                            child: Text(
                              "Amount",
                              style: context.textTheme.bodySmall,
                              textAlign: TextAlign.start,
                            ),
                          ),
                          alignment: Alignment.centerLeft,
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        InputField(
                          controller: amountController,
                          keyboardType: TextInputType.numberWithOptions(
                            decimal: true,
                            signed: false,
                          ),
                          borderColor: AppColors.fieldColor,
                          vPadding: 16,
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
                          label: "Enter Amount", textInputAction: TextInputAction.done,
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child:
                              BlocConsumer<WithdrawSaveCubit, WithdrawSaveState>(
                            listener: (context, withdrawSaveState) {
                              if (withdrawSaveState.withdrawStatus ==
                                  WithdrawSaveStatus.loading) {
                                ToastLoader.show();
                              } else if (withdrawSaveState.withdrawStatus ==
                                  WithdrawSaveStatus.success) {
                                ToastLoader.remove();
                                DisplayUtils.showToast(
                                    context, "Withdraw successfully!");
                                NavRouter.pop(context);
                              } else if (withdrawSaveState.withdrawStatus ==
                                  WithdrawSaveStatus.error) {
                                ToastLoader.remove();
                                DisplayUtils.showToast(context,withdrawSaveState.message);
                              }
                            },
                            builder: (context, state) {
                              return PrimaryButton(
                                  onPressed: () {
                                    if (formKey.currentState!.validate()) {
                                      if (withdrawType != null && withdrawType.toString().isNotEmpty) {
                                        if (currency != null &&
                                            currency.toString().isNotEmpty) {
                                          context.read<WithdrawSaveCubit>()
                                            ..withdrawSave(WithdrawInput(
                                                amount:
                                                    amountController.text.trim(),
                                                currency: currency.toString(),
                                                withdraw_type:
                                                    withdrawType.toString()));
                                        } else {
                                          DisplayUtils.showToast(context,
                                              "Please select currency");
                                        }
                                      }else {
                                        DisplayUtils.showToast(context,
                                            "Please select withdraw type");
                                      }
                                    }
                                  },
                                  title: 'Save');
                            },
                          ),
                        ),
                        SizedBox(
                          height: 30,
                        ),
                      ],
                    ),
                  )),
                );
              }
              if (state.withdrawDataStatus == WithdrawDataStatus.error) {
                return Center(
                  child: Text(state.message,style: TextStyle(color: Colors.white)),
                );
              }
              return EmptyWidget();
            },
          )),
    );
  }
}
