import 'package:dollarax/constants/app_colors.dart';
import 'package:dollarax/modules/deposit/cubit/deposit_data/deposit_data_cubit.dart';
import 'package:dollarax/modules/deposit/cubit/deposit_data/deposit_data_state.dart';
import 'package:dollarax/modules/deposit/cubit/deposit_save/deposit_cubit.dart';
import 'package:dollarax/modules/deposit/models/deposit_input.dart';
import 'package:dollarax/modules/deposit/widgets/deposit_currency_widget.dart';
import 'package:dollarax/ui/widgets/base_scaffold.dart';
import 'package:dollarax/ui/widgets/custom_appbar.dart';
import 'package:dollarax/ui/widgets/custom_dropdown.dart';
import 'package:dollarax/ui/widgets/on_click.dart';
import 'package:dollarax/utils/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

import '../../../config/routes/nav_router.dart';
import '../../../core/di/service_locator.dart';
import '../../../ui/input/input_field.dart';
import '../../../ui/widgets/empty_widget.dart';
import '../../../ui/widgets/loading_indicator.dart';
import '../../../ui/widgets/primary_button.dart';
import '../../../ui/widgets/toast_loader.dart';
import '../../../utils/display/display_utils.dart';
import '../../common/image_picker/image_picker_cubit.dart';
import '../../common/repo/image_picker_repo.dart';
import '../cubit/deposit_save/deposit_state.dart';
import '../widgets/deposit_widget.dart';

class DepositPage extends StatefulWidget {
  const DepositPage({super.key});

  @override
  State<DepositPage> createState() => _DepositPageState();
}

class _DepositPageState extends State<DepositPage> {
  TextEditingController amountController = TextEditingController();
  TextEditingController transactionIdController = TextEditingController();
  String? currency;
  String? depositType;
  List<String> currencyIconsList = [
    "assets/images/png/ic_ustd_black.png",
    "assets/images/png/ic_bitcoin_yellow.png",
    "assets/images/png/ic_eth.png"
  ];

  List<String> depositTypes = ['Wallet', 'Investment'];
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => ImagePickerCubit(ImagePickerRepo()),
        ),
        BlocProvider(
          create: (context) => DepositCubit(sl()),
        ),
        BlocProvider(
          create: (context) => DepositDataCubit(sl())..depositData(),
        )
      ],
      child: BaseScaffold(
          appBar: CustomAppbar(
            title: "Deposit",
          ),
          safeAreaTop: true,
          body: BlocBuilder<ImagePickerCubit, ImagePickerState>(
            builder: (context, imagePickerState) {
              return BlocBuilder<DepositDataCubit, DepositDataState>(
                builder: (context, state) {
                  if (state.depositDataStatus == DepositDataStatus.loading) {
                    return Center(
                      child: LoadingIndicator(),
                    );
                  }
                  if (state.depositDataStatus == DepositDataStatus.success) {
                    return RefreshIndicator(
                      onRefresh: (){
                        return Future.delayed(
                          Duration(seconds: 1),
                              () {
                            context.read<DepositDataCubit>().depositData();
                          },
                        );
                      },
                      child: SingleChildScrollView(
                          child: Form(
                        key: formKey,
                        child: Column(
                          children: [
                            SizedBox(
                              height: 20,
                            ),
                            DepositWidget(
                                iconPath: "assets/images/png/ic_usdt.png",
                                title: "USDT Deposit",
                                price:
                                    "\$${state.depositModel!.usdtDepositsBalance}"),
                            DepositWidget(
                                iconPath:
                                    "assets/images/png/ic_bitcoin_yellow.png",
                                title: "BTC Deposit",
                                price:
                                    "\$${state.depositModel!.btcDepositsBalance}"),
                            DepositWidget(
                                iconPath: "assets/images/png/ic_eth.png",
                                title: "ETH Deposit",
                                price:
                                    "\$${state.depositModel!.ethDepositsBalance}"),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              "Transfer money by the address of the currency in which you want to Deposit",
                              style: context.textTheme.bodySmall?.copyWith(
                                  fontWeight: FontWeight.w300, fontSize: 11),
                            ),
                            SizedBox(
                              height: 8,
                            ),
                            Column(
                              children: List.generate(
                                  state.depositModel!.investmentCurrencies.length,
                                  (index) {
                                return DepositCurrencyWidget(
                                    onSelect: (value) {

                                    },
                                    leadingPath: currencyIconsList[index],
                                    investmentCurrency: state.depositModel!
                                        .investmentCurrencies[index],
                                    title:
                                        "${state.depositModel!.investmentCurrencies[index].name} Deposit Address");
                              }),
                            ),
                            SizedBox(
                              height: 16,
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
                                  "Deposit",
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
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 8),
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
                              height: 16,
                            ),
                            Align(
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 8),
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
                              items: state.depositModel!.investmentCurrencies
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
                            ),Align(
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 8),
                                child: Text(
                                  "Deposit Type",
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
                              hint: "Select Type",
                              items: depositTypes
                                  .map((e) => e)
                                  .toList(),
                              enable: true,
                              hintColor: AppColors.grey1,
                              suffixIconPath:
                                  "assets/images/png/ic_drop_down_yellow.png",
                              onSelect: (value) {
                                setState(() {
                                  if(value == 'Wallet'){
                                    depositType = 'trade';
                                  }else if(value == 'Investment'){
                                    depositType = 'investment';
                                  }
                                });
                              },
                            ),
                            SizedBox(
                              height: 16,
                            ),
                            Align(
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 8),
                                child: Text(
                                  "Image",
                                  style: context.textTheme.bodySmall,
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
                                context
                                    .read<ImagePickerCubit>()
                                    .pickImage(ImageSource.gallery);
                              },
                              child: Container(
                                height: 46,
                                padding: EdgeInsets.symmetric(horizontal: 16),
                                decoration: BoxDecoration(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(6)),
                                    color: AppColors.fieldColor,
                                    border: Border.all(
                                      width: 1,
                                      color: AppColors.secondary,
                                    )),
                                child: Row(
                                  children: [
                                    Container(
                                      child: Text("Choose File",
                                          style: context.textTheme.bodySmall
                                              ?.copyWith(
                                                  color: AppColors.black,
                                                  fontSize: 10)),
                                      color: AppColors.offWhiteColor,
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 20, vertical: 4),
                                    ),
                                    SizedBox(
                                      width: 8,
                                    ),
                                    Expanded(
                                      child: Text(
                                        imagePickerState.hasImage
                                            ? imagePickerState.file!.path.toString()
                                            : "No File Chosen",
                                        style:
                                            context.textTheme.bodySmall?.copyWith(
                                          color: AppColors.grey1,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                        maxLines: 1,
                                      ),
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
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 8),
                                child: Text(
                                  "Transaction ID",
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
                              controller: transactionIdController,
                              label: "Enter Transaction ID",
                            ),
                            SizedBox(
                              height: 30,
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 16),
                              child: BlocConsumer<DepositCubit, DepositState>(
                                listener: (context, depositState) async {
                                  if (depositState.depositStatus ==
                                      DepositStatus.loading) {
                                    ToastLoader.show();
                                  } else if (depositState.depositStatus ==
                                      DepositStatus.success) {
                                    ToastLoader.remove();
                                    DisplayUtils.showToast(
                                        context, depositState.message);
                                    NavRouter.pop(context);
                                  } else if (depositState.depositStatus ==
                                      DepositStatus.error) {
                                    ToastLoader.remove();
                                    DisplayUtils.showToast(context,depositState.message);
                                  }
                                },
                                builder: (context, state) {
                                  return PrimaryButton(
                                      onPressed: () {
                                        if (formKey.currentState!.validate()) {
                                          if (currency != null &&
                                              currency.toString().isNotEmpty) {
                                            if(depositType != null){
                                              if (imagePickerState.hasImage) {
                                                DepositInput input = DepositInput(
                                                    amount: amountController
                                                        .text
                                                        .trim(),
                                                    currency:
                                                    currency.toString(),
                                                    trans_id:
                                                    transactionIdController
                                                        .text
                                                        .trim(),deposit_data_type: depositType.toString());
                                                print(input.toJson());
                                                context.read<DepositCubit>()
                                                  ..depositSave(
                                                    input,
                                                    imagePickerState.file,
                                                  );
                                              } else {
                                                DisplayUtils.showToast(context,
                                                    "Please select image");
                                              }
                                            }else {
                                              DisplayUtils.showToast(context,
                                                  "Please select deposit type");
                                            }
                                          } else {
                                            DisplayUtils.showToast(context,
                                                "Please select currency");
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

                  if (state.depositDataStatus == DepositDataStatus.loading) {
                    return Center(
                      child: Text(state.message),
                    );
                  }
                  return EmptyWidget();
                },
              );
            },
          )),
    );
  }
}
