import 'package:dollarax/config/config.dart';
import 'package:dollarax/constants/app_colors.dart';
import 'package:dollarax/core/di/service_locator.dart';
import 'package:dollarax/modules/kyc_verification/cubit/country_list/country_list_cubit.dart';
import 'package:dollarax/modules/kyc_verification/cubit/country_list/country_list_state.dart';
import 'package:dollarax/modules/kyc_verification/models/country_list_response.dart';
import 'package:dollarax/modules/transfer/cubit/transfer_cubit.dart';
import 'package:dollarax/modules/transfer/cubit/transfer_state.dart';
import 'package:dollarax/modules/transfer/models/transfer_input.dart';
import 'package:dollarax/modules/transfer/widgets/recent_payee_widget.dart';
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

class TransferPage extends StatefulWidget {
  final List<CurrencyModel> currenciesList;
  final List<RecentFundReceiver> recentFundReceivers;
  const TransferPage({super.key, required this.currenciesList, required this.recentFundReceivers});

  @override
  State<TransferPage> createState() => _TransferPageState();
}

class _TransferPageState extends State<TransferPage> {
  String? currencyName;
  TextEditingController dollarAxIdController = TextEditingController();
  TextEditingController amountController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => TransferCubit(sl()),
      child: Scaffold(
        appBar: CustomAppbar(
          title: "Transfer",
        ),
        backgroundColor: AppColors.black,
        body: BlocConsumer<TransferCubit, TransferState>(
          listener: (context, state) {
            if (state.transferStatus == TransferStatus.loading) {
              ToastLoader.show();
            } else if (state.transferStatus == TransferStatus.success) {
              ToastLoader.remove();
              DisplayUtils.showToast(context, state.message);
              NavRouter.pop(context);
            } else if (state.transferStatus == TransferStatus.failure) {
              ToastLoader.remove();
              DisplayUtils.showToast(context, state.message);
            }
          },
          builder: (context, state) {
            return Form(
              key: formKey,
              child: SingleChildScrollView(
                padding: EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      children: [
                        Text(
                          "Send to ",
                          style: context.textTheme.bodyLarge
                              ?.copyWith(
                              fontWeight: FontWeight.w400, fontSize: 22),
                        ),
                        Text(
                          "DollarAx User",
                          style: context.textTheme.bodyLarge?.copyWith(
                              fontWeight: FontWeight.w400,
                              color: AppColors.secondary,
                              fontSize: 22),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 24,
                    ),
                    Text(
                      "New payee",
                      style: context.textTheme.bodyLarge,
                    ),
                    SizedBox(
                      height: 24,
                    ),
                    Align(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        child: Text(
                          "DollarAx ID",
                          style: context.textTheme.bodyMedium,
                          textAlign: TextAlign.start,
                        ),
                      ),
                      alignment: Alignment.centerLeft,
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    InputField.name(
                      controller: dollarAxIdController,
                      label: "Enter DollarAx ID",
                    ),
                    SizedBox(
                      height: 16,
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
                      items: widget.currenciesList.map((e) => e.currency).toList(),
                      enable: true,
                      hintColor: AppColors.grey1,
                      suffixIconPath: "assets/images/png/ic_drop_down_yellow.png",
                      onSelect: (value) {
                        CurrencyModel currencyModel = widget.currenciesList
                            .firstWhere((element) => element.currency == value);
                        currencyName = currencyModel.currency;
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
                    PrimaryButton(
                        onPressed: () {
                          if (formKey.currentState!.validate()) {
                            if (currencyName != null) {
                              context.read<TransferCubit>()
                                ..fundTransfer(
                                    TransferInput(
                                        amount: amountController.text.trim(),
                                        currency: currencyName.toString(),
                                        referral_id: dollarAxIdController.text
                                            .trim()));
                            } else {
                              DisplayUtils.showToast(context, 'Select your currency');
                            }
                          }
                        },
                        title: 'Transfer'),
                    SizedBox(height: 30,),
                    Divider(color: AppColors.secondary,thickness: .5,),
                    SizedBox(height: 20,),
                    Text(
                      "Recent Payee",
                      style: context.textTheme.bodyLarge,
                    ),
                    SizedBox(height: 8,),
                    Column(
                      children: List.generate(widget.recentFundReceivers.length, (index) {
                        return RecentPayeeWidget(fundReceiver: widget.recentFundReceivers[index]);
                      }),
                    )
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
