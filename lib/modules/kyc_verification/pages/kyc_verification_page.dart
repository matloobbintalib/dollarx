import 'dart:io';

import 'package:dollarax/config/routes/nav_router.dart';
import 'package:dollarax/modules/kyc_verification/cubit/country_list/country_list_cubit.dart';
import 'package:dollarax/modules/kyc_verification/cubit/country_list/country_list_state.dart';
import 'package:dollarax/modules/kyc_verification/cubit/kyc_verification/kyc_verification_cubit.dart';
import 'package:dollarax/modules/kyc_verification/cubit/kyc_verification/kyc_verification_state.dart';
import 'package:dollarax/modules/kyc_verification/models/country_list_response.dart';
import 'package:dollarax/modules/kyc_verification/models/kyc_verification_input.dart';
import 'package:dollarax/modules/user/models/user_model.dart';
import 'package:dollarax/modules/user/repository/user_account_repository.dart';
import 'package:dollarax/ui/dialogs/country_dialog.dart';
import 'package:dollarax/ui/dialogs/dialog_utils.dart';
import 'package:dollarax/ui/widgets/custom_appbar.dart';
import 'package:dollarax/ui/widgets/empty_widget.dart';
import 'package:dollarax/ui/widgets/loading_indicator.dart';
import 'package:dollarax/ui/widgets/on_click.dart';
import 'package:dollarax/ui/widgets/primary_button.dart';
import 'package:dollarax/ui/widgets/profile_picture_widget.dart';
import 'package:dollarax/ui/widgets/toast_loader.dart';
import 'package:dollarax/utils/display/display_utils.dart';
import 'package:dollarax/utils/extensions/extended_context.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

import '../../../constants/app_colors.dart';
import '../../../core/di/service_locator.dart';
import '../../../ui/widgets/custom_dropdown.dart';
import '../../common/image_picker/image_picker_cubit.dart';
import '../../common/repo/image_picker_repo.dart';

class KycVerificationPage extends StatefulWidget {
  final UserModel userModel;

  const KycVerificationPage({super.key, required this.userModel});

  @override
  State<KycVerificationPage> createState() => _KycVerificationPageState();
}

class _KycVerificationPageState extends State<KycVerificationPage> {
  List<String> identityList = ["ID Card", "Passport", "Driving license"];

  String _selectedIdentityValue = "ID Card";
  String? countryName;
  bool isSelfie = false;
  String? frontIdUrl;
  String? backIdUrl;
  String? identityUrl;
  File? frontIdImage;
  File? backIdImage;

  @override
  void initState() {
    super.initState();
    if (widget.userModel.kycDocType != null) {
      _selectedIdentityValue = widget.userModel.kycDocType.toString();
    }
    frontIdUrl = widget.userModel.cnicFont;
    backIdUrl = widget.userModel.cnicBack;
    identityUrl = widget.userModel.kycDocument;
    countryName = widget.userModel.country;
  }

  Widget buildRadioButton(String label) {
    return Row(
      children: [
        Radio(
          value: label,
          groupValue: _selectedIdentityValue,
          activeColor: AppColors.secondary,
          onChanged: (String? value) {
            setState(() {
              _selectedIdentityValue = value.toString();
            });
          },
        ),
        Text(
          label,
          style: context.textTheme.bodySmall
              ?.copyWith(fontWeight: FontWeight.w300, fontSize: 11),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => ImagePickerCubit(ImagePickerRepo()),
        ),
        BlocProvider(
          create: (context) => CountryListCubit(sl())..countryLists(),
        ),
        BlocProvider(
          create: (context) => KycVerificationCubit(sl()),
        ),
      ],
      child: Scaffold(
        appBar: CustomAppbar(
          title: "Proof Of Identity",
        ),
        backgroundColor: Colors.black,
        body: BlocBuilder<ImagePickerCubit, ImagePickerState>(
          builder: (context, imagePickerState) {
            if (imagePickerState.frontImageFile != null) {
              frontIdImage = imagePickerState.frontImageFile;
            }
            if (imagePickerState.backImageFile != null) {
              backIdImage = imagePickerState.backImageFile;
            }
            return BlocBuilder<CountryListCubit, CountryListState>(
              builder: (context, countryState) {
                if (countryState.countryListStatus ==
                    CountryListStatus.loading) {
                  return Center(
                    child: LoadingIndicator(),
                  );
                }
                if (countryState.countryListStatus ==
                    CountryListStatus.success) {
                  return SingleChildScrollView(
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
                            showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return CountryDialog(
                                    countries: countryState.countryLists
                                        .map((e) => e.name)
                                        .toList(),
                                    onSelect: (value) {
                                      CountryModel countryModel = countryState
                                          .countryLists
                                          .firstWhere((element) =>
                                              element.name == value);
                                      countryName = countryModel.name;
                                      setState(() {});
                                    },
                                  );
                                });
                          },
                          child: Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 16, vertical: 12),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(6),
                                color: AppColors.fieldColor,
                                border: Border.all(color: AppColors.secondary)),
                            child: Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    countryName != null
                                        ? countryName.toString()
                                        : "Select Your Country",
                                    style: TextStyle(
                                        fontSize: 11,
                                        color: Colors.white,
                                        fontWeight: FontWeight.w300),
                                  ),
                                ),
                                Image.asset(
                                  'assets/images/png/ic_drop_down_yellow.png',
                                  width: 12,
                                  height: 12,
                                )
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Text(
                          "In Order to completed your registration\nPlease upload a copy of your identity with\na Clear selfie photo to proof the documents holder",
                          style: context.textTheme.bodySmall?.copyWith(
                              fontWeight: FontWeight.w200, fontSize: 11),
                          textAlign: TextAlign.start,
                        ),
                        SizedBox(
                          height: 40,
                        ),
                        Text(
                          "Choose your Identity type",
                          style: context.textTheme.bodySmall?.copyWith(
                              fontWeight: FontWeight.w300, fontSize: 11),
                          textAlign: TextAlign.start,
                        ),
                        Theme(
                          data: ThemeData(
                            unselectedWidgetColor: Colors.white,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              buildRadioButton('ID Card'),
                              buildRadioButton('Passport'),
                              buildRadioButton('Driving license'),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Expanded(
                                child: OnClick(
                              onTap: () async {
                                String res =
                                    await DialogUtils.uploadPictureDialog(
                                        context);
                                if (res == 'gallery')
                                  context
                                      .read<ImagePickerCubit>()
                                      .pickFrontImage(ImageSource.gallery);
                                if (res == 'camera')
                                  context
                                      .read<ImagePickerCubit>()
                                      .pickFrontImage(ImageSource.camera);
                              },
                              child: Container(
                                height: 120,
                                decoration: BoxDecoration(
                                    border:
                                        Border.all(color: AppColors.secondary),
                                    borderRadius: BorderRadius.circular(6)),
                                child: Column(
                                  children: [
                                    Text(
                                      "Front ID",
                                      style: context.textTheme.bodyLarge
                                          ?.copyWith(
                                              color: AppColors.secondary),
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Image.asset(
                                      "assets/images/png/ic_camera.png",
                                      height: 50,
                                      width: 50,
                                    )
                                  ],
                                  mainAxisAlignment: MainAxisAlignment.center,
                                ),
                              ),
                            )),
                            SizedBox(
                              width: 10,
                            ),
                            Expanded(
                                child: OnClick(
                              onTap: () async {
                                String res =
                                    await DialogUtils.uploadPictureDialog(
                                        context);
                                if (res == 'gallery')
                                  context
                                      .read<ImagePickerCubit>()
                                      .pickBackImage(ImageSource.gallery);
                                if (res == 'camera')
                                  context
                                      .read<ImagePickerCubit>()
                                      .pickBackImage(ImageSource.camera);
                              },
                              child: Container(
                                height: 120,
                                decoration: BoxDecoration(
                                    border:
                                        Border.all(color: AppColors.secondary),
                                    borderRadius: BorderRadius.circular(6)),
                                child: Column(
                                  children: [
                                    Text(
                                      "Back ID",
                                      style: context.textTheme.bodyLarge
                                          ?.copyWith(
                                              color: AppColors.secondary),
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Image.asset(
                                      "assets/images/png/ic_camera.png",
                                      height: 50,
                                      width: 50,
                                    )
                                  ],
                                  mainAxisAlignment: MainAxisAlignment.center,
                                ),
                              ),
                            ))
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Expanded(
                                child: Container(
                              height: 120,
                              decoration: BoxDecoration(
                                  border:
                                      Border.all(color: AppColors.secondary),
                                  borderRadius: BorderRadius.circular(6)),
                              child: ProfilePictureWidget(
                                width: double.infinity,
                                showEditIcon: false,
                                borderRadius: 6,
                                profileUrl: frontIdImage != null
                                    ? frontIdImage!.path
                                    : frontIdUrl != null
                                        ? 'https://dollarax.com/' +
                                            frontIdUrl.toString()
                                        : "assets/images/png/image_not_found.png",
                                onTap: () async {},
                              ),
                            )),
                            SizedBox(
                              width: 10,
                            ),
                            Expanded(
                                child: Container(
                              height: 120,
                              decoration: BoxDecoration(
                                  border:
                                      Border.all(color: AppColors.secondary),
                                  borderRadius: BorderRadius.circular(6)),
                              child: ProfilePictureWidget(
                                showEditIcon: false,
                                width: double.infinity,
                                borderRadius: 6,
                                profileUrl: backIdImage != null
                                    ? backIdImage!.path
                                    : backIdUrl != null
                                        ? 'https://dollarax.com/' +
                                            backIdUrl.toString()
                                        : "assets/images/png/image_not_found.png",
                                onTap: () async {},
                              ),
                            ))
                          ],
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        SizedBox(
                          height: 60,
                        ),
                        BlocConsumer<KycVerificationCubit,
                            KycVerificationState>(
                          listener: (context, state) {
                            if (state.kycVerificationStatus ==
                                KycVerificationStatus.loading) {
                              ToastLoader.show();
                            } else if (state.kycVerificationStatus ==
                                KycVerificationStatus.success) {
                              ToastLoader.remove();
                              DisplayUtils.showToast(context, state.message);
                              NavRouter.pop(context);
                            } else if (state.kycVerificationStatus ==
                                KycVerificationStatus.error) {
                              ToastLoader.remove();
                              DisplayUtils.showToast(context, state.message);
                            }
                          },
                          builder: (context, state) {
                            return PrimaryButton(
                                onPressed: () {
                                  if (countryName == null) {
                                    DisplayUtils.showToast(
                                        context, "Select your country!");
                                  } else {
                                    if (_selectedIdentityValue.isNotEmpty) {
                                      if (frontIdImage != null) {
                                        if (backIdImage != null) {
                                          context.read<KycVerificationCubit>()
                                            ..addKycVerification(
                                                KycVerificationInput(
                                                    kyc_doc_type:
                                                        _selectedIdentityValue,
                                                    country:
                                                        countryName.toString()),
                                                frontIdImage,
                                                backIdImage,);
                                        } else {
                                          DisplayUtils.showToast(
                                              context, "Take ID Back image");
                                        }
                                      } else {
                                        DisplayUtils.showToast(
                                            context, "Take ID Front Image");
                                      }
                                    } else {
                                      DisplayUtils.showToast(
                                          context, "Select Identity Type");
                                    }
                                  }
                                },
                                title: 'Submit');
                          },
                        )
                      ],
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
            );
          },
        ),
      ),
    );
  }
}
