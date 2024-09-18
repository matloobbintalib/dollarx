import 'package:dollarax/config/routes/nav_router.dart';
import 'package:dollarax/constants/app_colors.dart';
import 'package:dollarax/core/di/service_locator.dart';
import 'package:dollarax/modules/common/image_picker/image_picker_cubit.dart';
import 'package:dollarax/modules/common/repo/image_picker_repo.dart';
import 'package:dollarax/modules/p2p_exchange/cubits/proof_upload/proof_upload_cubit.dart';
import 'package:dollarax/modules/p2p_exchange/cubits/proof_upload/proof_upload_state.dart';
import 'package:dollarax/modules/p2p_exchange/cubits/refresh_hold/refresh_hold_cubit.dart';
import 'package:dollarax/modules/p2p_exchange/cubits/refresh_hold/refresh_hold_state.dart';
import 'package:dollarax/modules/p2p_exchange/models/p2p_exchange_history_response.dart';
import 'package:dollarax/modules/p2p_exchange/models/p2p_proof_upload_input.dart';
import 'package:dollarax/ui/dialogs/dialog_utils.dart';
import 'package:dollarax/ui/widgets/primary_button.dart';
import 'package:dollarax/ui/widgets/toast_loader.dart';
import 'package:dollarax/utils/display/display_utils.dart';
import 'package:dollarax/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

class P2PBuyPage extends StatefulWidget {
  final P2PExchangeModel exchangeModel;

  const P2PBuyPage({super.key, required this.exchangeModel});

  @override
  State<P2PBuyPage> createState() => _P2PBuyPageState();
}

class _P2PBuyPageState extends State<P2PBuyPage> {
  TextEditingController amountController = new TextEditingController();
  bool showPaymentInfo = false;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => ImagePickerCubit(ImagePickerRepo()),
        ),
        BlocProvider(
          create: (context) => ProofUploadCubit(sl()),
        ),BlocProvider(
          create: (context) => RefreshHoldCubit(sl()),
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
              }),
          title: Text(
            'Buy USDT',
            style: context.textTheme.titleLarge
                ?.copyWith(color: Colors.black, fontWeight: FontWeight.w500),
            textAlign: TextAlign.center,
          ),
        ),
        backgroundColor: AppColors.secondary,
        body: BlocBuilder<ImagePickerCubit, ImagePickerState>(
          builder: (context, imagePickerState) {
            return BlocConsumer<ProofUploadCubit, ProofUploadState>(
              listener: (context, state) {
                if (state.proofUploadStatus == ProofUploadStatus.loading) {
                  ToastLoader.show();
                }
                if (state.proofUploadStatus == ProofUploadStatus.success) {
                  ToastLoader.remove();
                  DisplayUtils.showToast(context, state.message);
                  Navigator.pop(context);
                }
                if (state.proofUploadStatus == ProofUploadStatus.error) {
                  ToastLoader.remove();
                  DisplayUtils.showToast(context, state.message);
                }
              },
              builder: (context, state) {
                return Container(
                  width: double.infinity,
                  height: MediaQuery.of(context).size.height,
                  padding: EdgeInsets.symmetric(vertical: 10, horizontal: 8),
                  decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20),
                    ),
                  ),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            'Price  ${widget.exchangeModel.totalAmount}',
                            style: context.textTheme.bodySmall?.copyWith(
                                fontWeight: FontWeight.w400, fontSize: 10),
                          ),
                        ),
                        Container(
                          height: 40,
                          alignment: Alignment.centerLeft,
                          width: double.infinity,
                          padding: EdgeInsets.symmetric(horizontal: 12),
                          decoration: BoxDecoration(
                              border: Border.all(color: AppColors.secondary)),
                          child: Text(
                            widget.exchangeModel.bankName,
                            style: context.textTheme.bodySmall
                                ?.copyWith(fontWeight: FontWeight.w400),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 12) +
                              EdgeInsets.only(top: 16),
                          child: Row(
                            children: [
                              Text(
                                'Receive Quantity',
                                style: context.textTheme.bodySmall?.copyWith(
                                    fontWeight: FontWeight.w400,
                                    color: AppColors.hindColor),
                              ),
                              Spacer(),
                              Text(
                                '${widget.exchangeModel.sellCurrency} ${widget.exchangeModel.sellAmount}',
                                style: context.textTheme.bodySmall
                                    ?.copyWith(fontWeight: FontWeight.w400),
                              )
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                                horizontal: 12,
                              ) +
                              EdgeInsets.only(top: 8),
                          child: Row(
                            children: [
                              Text(
                                'Fiat Amount',
                                style: context.textTheme.bodySmall?.copyWith(
                                    fontWeight: FontWeight.w400,
                                    color: AppColors.hindColor),
                              ),
                              Spacer(),
                              Text(
                                '${widget.exchangeModel.buyCurrency} ${widget.exchangeModel.buyAmount}',
                                style: context.textTheme.bodySmall
                                    ?.copyWith(fontWeight: FontWeight.w400),
                              )
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 12, vertical: 8),
                          child: Text(
                            'Payment Time Limit 15 min',
                            style: context.textTheme.bodySmall?.copyWith(
                                fontWeight: FontWeight.w400,
                                color: AppColors.hindColor),
                          ),
                        ),
                        SizedBox(
                          height: 40,
                        ),
                        BlocConsumer<RefreshHoldCubit, RefreshHoldState>(
                          listener: (context, refreshHoldState) {
                            if(refreshHoldState.refreshHoldStatus == RefreshHoldStatus.loading){
                              ToastLoader.show();
                            }
                            if(refreshHoldState.refreshHoldStatus == RefreshHoldStatus.success){
                              ToastLoader.remove();
                              setState(() {
                                showPaymentInfo = true;
                              });
                            }
                            if(refreshHoldState.refreshHoldStatus == RefreshHoldStatus.error){
                              ToastLoader.remove();
                              DisplayUtils.showToast(context, refreshHoldState.message);
                            }
                          },
                          builder: (context, state) {
                            return PrimaryButton(
                              onPressed: () {
                                context.read<RefreshHoldCubit>().p2PRefreshHold(widget.exchangeModel.id);
                              },
                              title: 'View Payment Info',
                              backgroundColor: Color(0xff185d1b),
                              borderColor: AppColors.secondary,
                              borderRadius: 0,
                              fontWeight: FontWeight.w500,
                              titleColor: Colors.white,
                            );
                          },
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        if (showPaymentInfo) ...[
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 12, vertical: 8),
                            child: Text(
                              'Payment Details',
                              style: context.textTheme.bodyMedium
                                  ?.copyWith(fontWeight: FontWeight.w500),
                            ),
                          ),
                          Container(
                            width: double.infinity,
                            padding: EdgeInsets.symmetric(
                                horizontal: 12, vertical: 16),
                            decoration: BoxDecoration(
                                border: Border.all(color: AppColors.secondary)),
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      'You Pay',
                                      style: context.textTheme.bodyMedium
                                          ?.copyWith(
                                              fontWeight: FontWeight.w400,
                                              color: AppColors.hindColor),
                                    ),
                                    Spacer(),
                                    Text(
                                      '${widget.exchangeModel.buyCurrency} ${widget.exchangeModel.buyAmount}',
                                      style: context.textTheme.bodyMedium
                                          ?.copyWith(
                                              fontWeight: FontWeight.w400),
                                    ),
                                    IconButton(
                                        constraints: BoxConstraints(),
                                        style: const ButtonStyle(
                                          tapTargetSize: MaterialTapTargetSize
                                              .shrinkWrap, // the '2023' part
                                        ),
                                        padding: EdgeInsets.all(10),
                                        onPressed: () {
                                          copyText(
                                              widget.exchangeModel.buyAmount);
                                        },
                                        icon: Image.asset(
                                          "assets/images/png/icon_copy.png",
                                          height: 16,
                                          width: 16,
                                        ))
                                  ],
                                ),
                                Row(
                                  children: [
                                    Text(
                                      'Full Name',
                                      style: context.textTheme.bodyMedium
                                          ?.copyWith(
                                              fontWeight: FontWeight.w400,
                                              color: AppColors.hindColor),
                                    ),
                                    Spacer(),
                                    Text(
                                      widget.exchangeModel.accountName,
                                      style: context.textTheme.bodyMedium
                                          ?.copyWith(
                                              fontWeight: FontWeight.w400),
                                    ),
                                    IconButton(
                                        constraints: BoxConstraints(),
                                        style: const ButtonStyle(
                                          tapTargetSize: MaterialTapTargetSize
                                              .shrinkWrap, // the '2023' part
                                        ),
                                        padding: EdgeInsets.all(10),
                                        onPressed: () {
                                          copyText(
                                              widget.exchangeModel.accountName);
                                        },
                                        icon: Image.asset(
                                          "assets/images/png/icon_copy.png",
                                          height: 16,
                                          width: 16,
                                        ))
                                  ],
                                ),
                                Row(
                                  children: [
                                    Text(
                                      '${widget.exchangeModel.bankName} Account',
                                      style: context.textTheme.bodyMedium
                                          ?.copyWith(
                                              fontWeight: FontWeight.w400,
                                              color: AppColors.hindColor),
                                    ),
                                    Spacer(),
                                    Text(
                                      widget.exchangeModel.accountNo,
                                      style: context.textTheme.bodyMedium
                                          ?.copyWith(
                                              fontWeight: FontWeight.w400),
                                    ),
                                    IconButton(
                                        constraints: BoxConstraints(),
                                        style: const ButtonStyle(
                                          tapTargetSize: MaterialTapTargetSize
                                              .shrinkWrap, // the '2023' part
                                        ),
                                        padding: EdgeInsets.all(10),
                                        onPressed: () {
                                          copyText(
                                              widget.exchangeModel.accountNo);
                                        },
                                        icon: Image.asset(
                                          "assets/images/png/icon_copy.png",
                                          height: 16,
                                          width: 16,
                                        ))
                                  ],
                                ),
                                SizedBox(
                                  height: 16,
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 12, vertical: 8),
                            child: Text(
                              'Insure the payment is successful,then send Payment Screenshot to seller.',
                              style: context.textTheme.bodyMedium
                                  ?.copyWith(fontWeight: FontWeight.w400),
                            ),
                          ),
                          Align(
                              alignment: Alignment.center,
                              child: IconButton(
                                  onPressed: () async {
                                    String res =
                                        await DialogUtils.uploadPictureDialog(
                                            context);
                                    if (res == 'gallery')
                                      context
                                          .read<ImagePickerCubit>()
                                          .pickImage(ImageSource.gallery);
                                    if (res == 'camera')
                                      context
                                          .read<ImagePickerCubit>()
                                          .pickImage(ImageSource.camera);
                                  },
                                  icon: Image.asset(
                                    "assets/images/png/icon_camera.png",
                                    width: 70,
                                    height: 70,
                                  ))),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 12, vertical: 8),
                            child: Text(
                              imagePickerState.hasImage
                                  ? imagePickerState.file!.path
                                  : '',
                              style: context.textTheme.bodyMedium
                                  ?.copyWith(fontWeight: FontWeight.w400),
                            ),
                          ),
                          SizedBox(
                            height: 16,
                          ),
                          PrimaryButton(
                            onPressed: () {
                              if (imagePickerState.hasImage) {
                                context.read<ProofUploadCubit>()
                                  ..p2pBuyProofUpload(
                                      P2pProofUploadInput(
                                          p2p_id: widget.exchangeModel.id,
                                          prof_image: null),
                                      imagePickerState.file);
                              }
                            },
                            title: 'Done',
                            borderRadius: 30,
                            height: 40,
                          )
                        ]
                      ],
                    ),
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }

  void copyText(String data) {
    Clipboard.setData(ClipboardData(text: data)).then((_) {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Copied to your clipboard!')));
    });
  }
}
