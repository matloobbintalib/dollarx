import 'package:dollarax/constants/app_colors.dart';
import 'package:dollarax/modules/home/cubit/dashboard_refresh_cubit.dart';
import 'package:dollarax/modules/home/cubit/dashboard_refresh_state.dart';
import 'package:dollarax/modules/profile/models/update_profile_input.dart';
import 'package:dollarax/modules/user/models/user_model.dart';
import 'package:dollarax/ui/widgets/custom_dropdown.dart';
import 'package:dollarax/utils/custom_date_time_picker.dart';
import 'package:dollarax/utils/extensions/extended_context.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

import '../../../core/di/service_locator.dart';
import '../../../ui/dialogs/dialog_utils.dart';
import '../../../ui/input/input_field.dart';
import '../../../ui/widgets/custom_appbar.dart';
import '../../../ui/widgets/primary_button.dart';
import '../../../ui/widgets/profile_picture_widget.dart';
import '../../../ui/widgets/toast_loader.dart';
import '../../../utils/display/display_utils.dart';
import '../../common/image_picker/image_picker_cubit.dart';
import '../../common/repo/image_picker_repo.dart';
import '../cubit/update_profile/update_profile_cubut.dart';
import '../cubit/update_profile/update_profile_state.dart';

class UpdateProfilePge extends StatefulWidget {
  final UserModel userModel;

  const UpdateProfilePge({super.key, required this.userModel});

  @override
  State<UpdateProfilePge> createState() => _UpdateProfilePgeState();
}

class _UpdateProfilePgeState extends State<UpdateProfilePge> {

  TextEditingController nameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController dobController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController postalCodeController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  String? genderType;

  List<String> genderTypeList = ['Male', 'Female', 'Other'];
  final formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    nameController.text = widget.userModel.name;
    emailController.text = widget.userModel.email;
    phoneController.text = widget.userModel.mobile;
    addressController.text = widget.userModel.address.toString();
    cityController.text = widget.userModel.city.toString();
    genderType = widget.userModel.gender.toString();
    dobController.text = widget.userModel.dob.toString();
    postalCodeController.text = widget.userModel.postalCode.toString();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => ImagePickerCubit(ImagePickerRepo()),
        ),
        BlocProvider(
          create: (context) => UpdateProfileCubit(sl()),
        ),
        BlocProvider(
          create: (context) => DashBoardRefreshCubit(sl()),
        ),
      ],
      child: Scaffold(
        appBar: CustomAppbar(
          title: "Update Profile",
          leftBorder: true,
        ),
        backgroundColor: Colors.black,
        body: BlocBuilder<ImagePickerCubit, ImagePickerState>(
          builder: (context, imagePickerState) {
            return BlocConsumer<DashBoardRefreshCubit, DashBoardRefreshState>(
              listener: (context, dashBoardState) {
                if (dashBoardState.dashBoardStatus == DashBoardRefreshStatus.loading) {
                  ToastLoader.show();
                } else if (dashBoardState.dashBoardStatus == DashBoardRefreshStatus.success) {
                  ToastLoader.remove();
                  Navigator.pop(context);
                } else if (dashBoardState.dashBoardStatus == DashBoardRefreshStatus.error) {
                  ToastLoader.remove();
                  DisplayUtils.showToast(context, dashBoardState.message);
                }
              },
              builder: (context, state) {
                return Form(
                  key: formKey,
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Container(
                          height: 200,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(20),
                                bottomRight: Radius.circular(20)),
                            color: AppColors.secondary,
                          ),
                          child: Center(
                            child: ProfilePictureWidget(
                              profileUrl: imagePickerState.hasImage
                                  ? imagePickerState.file!.path
                                  : widget.userModel.profilePic != null &&
                                          widget.userModel.profilePic
                                              .toString()
                                              .isNotEmpty
                                      ? "https://dollarax.com/${widget.userModel.profilePic}"
                                      : "assets/images/png/placeholder.jpg",
                              onTap: () async {
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
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 40,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      child: Column(
                        children: [
                          Align(
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 8),
                              child: Text(
                                "Name",
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
                                controller: nameController,
                                label: "Type Your Name",
                              ),
                              SizedBox(
                                height: 16,
                              ),
                              Align(
                                child: Padding(
                                  padding:
                                      const EdgeInsets.symmetric(horizontal: 8),
                                  child: Text(
                                    "Email",
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
                                controller: emailController,
                                label: "Type Your Email",
                                readOnly: true,
                                textInputAction: TextInputAction.next,
                              ),
                              SizedBox(
                                height: 16,
                              ),
                              Align(
                                child: Padding(
                                  padding:
                                      const EdgeInsets.symmetric(horizontal: 8),
                                  child: Text(
                                    "Mobile Number",
                                    style: context.textTheme.bodyMedium,
                                    textAlign: TextAlign.start,
                                  ),
                                ),
                                alignment: Alignment.centerLeft,
                          ),
                          SizedBox(
                            height: 8,
                          ),
                          InputField.phone(
                            controller: phoneController,
                            label: "Type Your Mobile Number",
                          ),
                          SizedBox(
                            height: 16,
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: Column(
                                  children: [
                                    Align(
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 8),
                                        child: Text(
                                          "Gender",
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
                                      hint: genderType != null
                                          ? genderType.toString()
                                          : "Select Gender",
                                      items: genderTypeList
                                          .map((e) => e)
                                          .toList(),
                                      enable: true,
                                      hintColor: AppColors.grey1,
                                      suffixIconPath:
                                      "assets/images/png/ic_drop_down_yellow.png",
                                      onSelect: (value) {
                                        setState(() {
                                          genderType = value;
                                        });
                                      },
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                width: 16,
                              ),
                              Expanded(
                                child: Column(
                                  children: [
                                    Align(
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 8),
                                        child: Text(
                                          "Data Of Birth",
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
                                          controller: dobController,
                                          label: "DDMMYY",
                                          textInputAction: TextInputAction.done,
                                          suffixIcon: Image.asset(
                                            "assets/images/png/ic_drop_down_yellow.png",
                                            width: 12,
                                            height: 12,
                                          ),
                                          readOnly: true,
                                          onTap: () async {
                                            dobController.text = await CustomDateTimePicker.selectDate(context);
                                          },
                                        ),
                                      ],
                                    ),
                                  )
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
                                    "Residential Address",
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
                                controller: addressController,
                                label: "Type Your Residential Address",
                              ),
                              SizedBox(
                                height: 16,
                              ),
                              Row(
                                children: [
                                  Expanded(
                                    child: Column(
                                      children: [
                                        Align(
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 8),
                                            child: Text(
                                              "Postal Code",
                                              style:
                                                  context.textTheme.bodyMedium,
                                              textAlign: TextAlign.start,
                                            ),
                                          ),
                                          alignment: Alignment.centerLeft,
                                        ),
                                        SizedBox(
                                          height: 8,
                                        ),
                                        InputField.number(
                                          controller: postalCodeController,
                                          label: "Type Your Postal Code",
                                        ),
                                      ],
                                ),
                              ),
                              SizedBox(
                                width: 16,
                              ),
                              Expanded(
                                child: Column(
                                  children: [
                                    Align(
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                                horizontal: 8),
                                            child: Text(
                                              "City",
                                              style:
                                                  context.textTheme.bodyMedium,
                                              textAlign: TextAlign.start,
                                            ),
                                          ),
                                          alignment: Alignment.centerLeft,
                                        ),
                                        SizedBox(
                                          height: 8,
                                        ),
                                        InputField.name(
                                          controller: cityController,
                                          label: "Type Your City Name",
                                        ),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                              SizedBox(
                                height: 30,
                              ),
                              BlocConsumer<UpdateProfileCubit,
                                  UpdateProfileState>(
                                listener: (context, updateState) {
                                  if (updateState.updateProfileStatus ==
                                      UpdateProfileStatus.loading) {
                                    ToastLoader.show();
                                  } else if (updateState.updateProfileStatus ==
                                      UpdateProfileStatus.success) {
                                    ToastLoader.remove();
                                    DisplayUtils.showToast(
                                        context, updateState.message);
                                    context.read<DashBoardRefreshCubit>()
                                      ..dashBoardRefresh();
                                  } else if (updateState.updateProfileStatus ==
                                      UpdateProfileStatus.failure) {
                                    ToastLoader.remove();
                                    DisplayUtils.showToast(
                                        context, updateState.message);
                                  }
                                },
                                builder: (context, state) {
                                  return PrimaryButton(
                                      onPressed: () {
                                        if (formKey.currentState!.validate()) {
                                          if (genderType != null) {
                                            if (dobController.text
                                                .trim()
                                                .isNotEmpty) {
                                              print(UpdateProfileInput(
                                                      name: nameController.text
                                                          .trim(),
                                                      address: addressController
                                                          .text
                                                          .trim(),
                                                      city: cityController.text
                                                          .trim(),
                                                      mobile: phoneController
                                                          .text
                                                          .trim())
                                                  .toJson());
                                              context.read<UpdateProfileCubit>()
                                                ..updateProfile(
                                                    UpdateProfileInput(
                                                        name: nameController.text
                                                            .trim(),
                                                        address:
                                                            addressController
                                                                .text
                                                                .trim(),
                                                        city: cityController.text
                                                            .trim(),
                                                        mobile: phoneController
                                                            .text
                                                            .trim(),
                                                        dob: dobController.text
                                                            .trim(),
                                                        gender: genderType,
                                                        postal_code:
                                                            postalCodeController
                                                                .text
                                                                .trim()),
                                                    imagePickerState.file);
                                            } else {
                                              DisplayUtils.showToast(context,
                                                  'Select Date Of Birth');
                                            }
                                          } else {
                                            DisplayUtils.showToast(
                                                context, 'Select Gender');
                                          }
                                        }
                                      },
                                      title: 'Update');
                                },
                              ),
                              SizedBox(
                                height: 30,
                              ),
                            ],
                          ),
                        )
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
}
