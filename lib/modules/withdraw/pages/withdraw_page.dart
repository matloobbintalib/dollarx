import 'package:dollarx/constants/app_colors.dart';
import 'package:dollarx/modules/investment/widgets/investment_widget.dart';
import 'package:dollarx/modules/withdraw/cubit/withdraw_data/withdraw_data_cubit.dart';
import 'package:dollarx/modules/withdraw/cubit/withdraw_data/withdraw_data_state.dart';
import 'package:dollarx/modules/withdraw/cubit/withdraw_save/withdraw_save_cubit.dart';
import 'package:dollarx/modules/withdraw/cubit/withdraw_save/withdraw_save_state.dart';
import 'package:dollarx/modules/withdraw/models/withdraw_input.dart';
import 'package:dollarx/ui/widgets/base_scaffold.dart';
import 'package:dollarx/ui/widgets/custom_appbar.dart';
import 'package:dollarx/ui/widgets/custom_dropdown.dart';
import 'package:dollarx/ui/widgets/empty_widget.dart';
import 'package:dollarx/ui/widgets/loading_indicator.dart';
import 'package:dollarx/utils/display/display_utils.dart';
import 'package:dollarx/utils/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
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
                return SingleChildScrollView(
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
                              "\$${state.withdrawModel!.usdtWithdrawBalance}"),
                      DepositWidget(
                          iconPath: "assets/images/png/ic_bitcoin_yellow.png",
                          title: "BTC Withdrawals",
                          price:
                              "\$${state.withdrawModel!.btcWithdrawBalance}"),
                      DepositWidget(
                          iconPath: "assets/images/png/ic_eth.png",
                          title: "ETH Withdrawals",
                          price:
                              "\$${state.withdrawModel!.ethWithdrawBalance}"),
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
                      CustomDropDown(
                        hint: "Available Balance",
                        items: [],
                        prefixIconPath:
                            "assets/images/png/ic_available_balance.png",
                      ),
                      SizedBox(
                        height: 16,
                      ),
                      CustomDropDown(
                        hint: "Available Bonus",
                        items: [],
                        prefixIconPath:
                            "assets/images/png/ic_available_bonus.png",
                      ),
                      SizedBox(
                        height: 16,
                      ),
                      CustomDropDown(
                        hint: "Available Profit",
                        items: [],
                        prefixIconPath:
                            "assets/images/png/ic_available_profit.png",
                      ),
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
                      /*Align(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8),
                          child: Text(
                            "Your Wallet Address",
                            style: context.textTheme.bodySmall,
                            textAlign: TextAlign.start,
                          ),
                        ),
                        alignment: Alignment.centerLeft,
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      InputField.name(
                        controller: walletAddressController,
                        label: "Enter Wallet Address",
                      ),
                      SizedBox(
                        height: 16,
                      ),*/
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
                      InputField.number(
                        controller: amountController,
                        label: "Enter Amount",
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
                                  context, withdrawSaveState.message);
                              NavRouter.pop(context);
                            } else if (withdrawSaveState.withdrawStatus ==
                                WithdrawSaveStatus.error) {
                              ToastLoader.remove();
                              context.showSnackBar(withdrawSaveState.message);
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
                                        context.showSnackBar(
                                            "Please select currency");
                                      }
                                    }else {
                                      context.showSnackBar(
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
                ));
              }
              if (state.withdrawDataStatus == WithdrawDataStatus.error) {
                return Center(
                  child: Text(state.message),
                );
              }
              return EmptyWidget();
            },
          )),
    );
  }
}
