import 'package:dollarax/config/config.dart';
import 'package:dollarax/core/di/service_locator.dart';
import 'package:dollarax/modules/bank_account/cubit/add_bank_info_cubit.dart';
import 'package:dollarax/modules/bank_account/cubit/add_bank_info_state.dart';
import 'package:dollarax/modules/bank_account/models/bank_info_input.dart';
import 'package:dollarax/modules/kyc_verification/cubit/country_list/country_list_cubit.dart';
import 'package:dollarax/modules/kyc_verification/cubit/country_list/country_list_state.dart';
import 'package:dollarax/modules/kyc_verification/models/country_list_response.dart';
import 'package:dollarax/modules/user/models/user_model.dart';
import 'package:dollarax/modules/user/repository/user_account_repository.dart';
import 'package:dollarax/ui/dialogs/country_dialog.dart';
import 'package:dollarax/ui/widgets/empty_widget.dart';
import 'package:dollarax/ui/widgets/loading_indicator.dart';
import 'package:dollarax/ui/widgets/on_click.dart';
import 'package:dollarax/ui/widgets/toast_loader.dart';
import 'package:dollarax/utils/display/display_utils.dart';
import 'package:dollarax/utils/extensions/extended_context.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../constants/app_colors.dart';
import '../../../ui/input/input_field.dart';
import '../../../ui/widgets/custom_appbar.dart';
import '../../../ui/widgets/custom_dropdown.dart';
import '../../../ui/widgets/primary_button.dart';

class BankAccountPage extends StatefulWidget {
  final UserModel  userModel;
  const BankAccountPage({super.key, required this.userModel});

  @override
  State<BankAccountPage> createState() => _BankAccountPageState();
}

class _BankAccountPageState extends State<BankAccountPage> {
  TextEditingController bankNameController = TextEditingController();
  TextEditingController accountTitleController = TextEditingController();
  TextEditingController accountNumberController = TextEditingController();
  TextEditingController ethAddressController = TextEditingController();
  TextEditingController btcAddressController = TextEditingController();
  TextEditingController usdtAddressController = TextEditingController();
  TextEditingController searchController = TextEditingController();
  String? countryName;
  UserAccountRepository _userAccountRepository = sl<UserAccountRepository>();
  final formKey = GlobalKey<FormState>();
  @override
  void initState() {
    super.initState();
    bankNameController.text = widget.userModel.bankName.toString() == 'null'?"":widget.userModel.bankName.toString();
    accountTitleController.text = widget.userModel.bankAccountName.toString() == 'null'?"":widget.userModel.bankAccountName.toString();
    accountNumberController.text =  widget.userModel.bankIbanNo.toString() == 'null'?"":widget.userModel.bankIbanNo.toString();
    if(widget.userModel.ethAddress != null){
      ethAddressController.text = widget.userModel.ethAddress.toString();
    }

    if(widget.userModel.country != null){
      countryName = widget.userModel.country;
    }
    if(widget.userModel.btcAddress != null){
      btcAddressController.text = widget.userModel.btcAddress.toString();
    }
    if(widget.userModel.usdtAddress != null){
      usdtAddressController.text = widget.userModel.usdtAddress.toString();
    }

  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) =>
          CountryListCubit(sl())
            ..countryLists(),
        ),
        BlocProvider(
          create: (context) => BankInfoCubit(sl()),
        ),
      ],
      child: Scaffold(
        appBar: CustomAppbar(
          title: "Payment Profile",
        ),
        backgroundColor: Colors.black,
        body: BlocBuilder<CountryListCubit, CountryListState>(
          builder: (context, countryState) {
            if (countryState.countryListStatus == CountryListStatus.loading) {
              return Center(
                child: LoadingIndicator(),
              );
            }
            if (countryState.countryListStatus == CountryListStatus.success) {
              return Form(
                key: formKey,
                child: SingleChildScrollView(
                  padding: EdgeInsets.symmetric(horizontal: 24, vertical: 40),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Align(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8),
                          child: Text(
                            "Country",
                            style: context.textTheme.bodyMedium,
                            textAlign: TextAlign.start,
                          ),
                        ),
                        alignment: Alignment.centerLeft,
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      OnClick(
                        onTap: () {
                          showDialog(context: context, builder: (BuildContext context){
                            return CountryDialog( countries: countryState.countryLists
                                .map((e) => e.name)
                                .toList(), onSelect: (value ) {
                              CountryModel countryModel = countryState.countryLists
                                  .firstWhere((element) => element.name == value);
                              countryName = countryModel.name;
                              setState(() {

                              });
                            },);
                          });
                        },
                        child: Container(
                          padding: EdgeInsets.symmetric(horizontal: 16,vertical: 12),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(6),
                            color: AppColors.fieldColor,
                            border: Border.all(color: AppColors.secondary)
                          ),
                          child: Row(
                            children: [
                              Expanded(child: Text(countryName!= null? countryName.toString(): "Select Your Country",style: TextStyle(
                                  fontSize: 11, color: Colors.white, fontWeight: FontWeight.w300
                              ),),),
                              Image.asset('assets/images/png/ic_drop_down_yellow.png' ,
                                width: 12,
                                height: 12,
                              )
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 16,
                      ),
                      Align(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8),
                          child: Text(
                            "Payment Method",
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
                        controller: bankNameController,
                        label: "Type Your Bank Name",
                      ),
                      SizedBox(
                        height: 16,
                      ),
                      Align(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8),
                          child: Text(
                            "Account Title",
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
                        controller: accountTitleController,
                        label: "Type Your Account Title",
                      ),
                      SizedBox(
                        height: 16,
                      ),
                      Align(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8),
                          child: Text(
                            "Payment/Account Number",
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
                        controller: accountNumberController,
                        label: "Type Your Account Number",
                      ),
                      SizedBox(
                        height: 16,
                      ),
                      Align(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8),
                          child: Text(
                            "BTC Address",
                            style: context.textTheme.bodyMedium,
                            textAlign: TextAlign.start,
                          ),
                        ),
                        alignment: Alignment.centerLeft,
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      InputField(
                        textInputAction: TextInputAction.done,
                        keyboardType: TextInputType.text,
                        controller: btcAddressController,
                        label: "Type Your BTC Address",
                      ),
                      SizedBox(
                        height: 16,
                      ),
                      Align(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8),
                          child: Text(
                            "ETH Address",
                            style: context.textTheme.bodyMedium,
                            textAlign: TextAlign.start,
                          ),
                        ),
                        alignment: Alignment.centerLeft,
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      InputField(
                        textInputAction: TextInputAction.done,
                        keyboardType: TextInputType.text,
                        controller: ethAddressController,
                        label: "Type Your ETH Address",
                      ),
                      SizedBox(
                        height: 16,
                      ),
                      Align(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8),
                          child: Text(
                            "USDT Address",
                            style: context.textTheme.bodyMedium,
                            textAlign: TextAlign.start,
                          ),
                        ),
                        alignment: Alignment.centerLeft,
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      InputField(
                        textInputAction: TextInputAction.done,
                        keyboardType: TextInputType.text,
                        controller: usdtAddressController,
                        label: "Type Your USDT Address",
                      ),
                      SizedBox(
                        height: 40,
                      ),
                      BlocConsumer<BankInfoCubit, BankInfoState>(
                        listener: (context, state) {
                          if (state.bankInfoStatus == BankInfoStatus.loading) {
                            ToastLoader.show();
                          } else
                          if (state.bankInfoStatus == BankInfoStatus.success) {
                            ToastLoader.remove();
                            DisplayUtils.showToast(context, state.message);
                            NavRouter.pop(context);
                          } else
                          if (state.bankInfoStatus == BankInfoStatus.error) {
                            ToastLoader.remove();
                            DisplayUtils.showToast(context, state.message);
                          }
                        },
                        builder: (context, state) {
                          return PrimaryButton(
                              onPressed: () {
                                if (countryName == null) {
                                  DisplayUtils.showToast(context,"Select your country!");
                                } else {
                                  if (formKey.currentState!.validate()) {
                                    context.read<BankInfoCubit>()
                                      ..addBankInfo(BankInfoInput(
                                          bank_name: bankNameController.text
                                              .trim(),
                                          bank_account_name:
                                          accountTitleController.text.trim(),
                                          bank_iban_no:
                                          accountNumberController.text.trim(),
                                          btc_address:
                                          btcAddressController.text.trim(),
                                          eth_address:
                                          ethAddressController.text.trim(),
                                          usdt_address:
                                          usdtAddressController.text.trim(),
                                          country: countryName.toString()));
                                  }
                                }
                              },
                              title: 'Submit');
                        },
                      )
                    ],
                  ),
                ),
              );
            }
            if (countryState.countryListStatus == CountryListStatus.error) {
              return Center(
                child: Text(countryState.message),
              );
            }

            return EmptyWidget();
          },
        ),
      ),
    );
  }
}
