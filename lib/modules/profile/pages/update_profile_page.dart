import 'package:dollarx/constants/app_colors.dart';
import 'package:dollarx/modules/profile/models/update_profile_input.dart';
import 'package:dollarx/modules/user/models/user_model.dart';
import 'package:dollarx/utils/extensions/extended_context.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

import '../../../config/routes/nav_router.dart';
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
import '../../user/repository/user_account_repository.dart';
import '../cubit/update_profile/update_profile_cubut.dart';
import '../cubit/update_profile/update_profile_state.dart';

class UpdateProfilePge extends StatefulWidget {
  const UpdateProfilePge({super.key});

  @override
  State<UpdateProfilePge> createState() => _UpdateProfilePgeState();
}

class _UpdateProfilePgeState extends State<UpdateProfilePge> {
  UserAccountRepository _userAccountRepository = sl<UserAccountRepository>();

  late UserModel userModel;
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
    userModel = _userAccountRepository.getUserFromDb();
    nameController.text = userModel.name;
    emailController.text = userModel.email;
    phoneController.text = userModel.mobile;
    addressController.text = userModel.address.toString();
    cityController.text = userModel.city.toString();
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
      ],
      child: Scaffold(
        appBar: CustomAppbar(
          title: "Update Profile",
          leftBorder: true,
        ),
        backgroundColor: Colors.black,
        body: BlocBuilder<ImagePickerCubit, ImagePickerState>(
          builder: (context, imagePickerState) {
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
                              : userModel.profilePic != null &&
                                      userModel.profilePic.toString().isNotEmpty
                                  ? "https://dollarax.com/${userModel.profilePic}"
                                  : "assets/images/png/placeholder.jpg",
                          onTap: () async {
                            String res =
                                await DialogUtils.uploadPictureDialog(context);
                            if (res == 'gallery')
                              context
                                  .read<ImagePickerCubit>()
                                  .pickImage(ImageSource.gallery);
                            if (res == 'camera')
                              context
                                  .read<ImagePickerCubit>()
                                  .pickImage(ImageSource.camera);
                            print(res);
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
                            height: 8,
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
                            height: 8,
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
                            height: 8,
                          ),
                          /*Row(
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
                                      hint: "Select Gender",
                                      items:
                                      genderTypeList.map((e) => e).toList(),
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
                                        dobController.text =
                                        await CustomDateTimePicker.selectDate(
                                            context);
                                      },
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),*/
                          SizedBox(
                            height: 8,
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
                            height: 8,
                          ),
                          Align(
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 8),
                              child: Text(
                                "City Name",
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
                            controller: cityController,
                            label: "Type Your City Name",
                          ),
                          /*Row(
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
                                          style: context.textTheme.bodyMedium,
                                          textAlign: TextAlign.start,
                                        ),
                                      ),
                                      alignment: Alignment.centerLeft,
                                    ),
                                    SizedBox(
                                      height: 8,
                                    ),
                                    InputField.email(
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
                                          style: context.textTheme.bodyMedium,
                                          textAlign: TextAlign.start,
                                        ),
                                      ),
                                      alignment: Alignment.centerLeft,
                                    ),
                                    SizedBox(
                                      height: 8,
                                    ),
                                    InputField.email(
                                      controller: cityController,
                                      label: "Type Your City Name",
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),*/
                          SizedBox(
                            height: 30,
                          ),
                          BlocConsumer<UpdateProfileCubit, UpdateProfileState>(
                            listener: (context, updateState) {
                              if (updateState.updateProfileStatus ==
                                  UpdateProfileStatus.loading) {
                                ToastLoader.show();
                              } else if (updateState.updateProfileStatus ==
                                  UpdateProfileStatus.success) {
                                ToastLoader.remove();
                                DisplayUtils.showToast(
                                    context, updateState.message);
                                NavRouter.pop(context);
                              } else if (updateState.updateProfileStatus ==
                                  UpdateProfileStatus.failure) {
                                ToastLoader.remove();
                                context.showSnackBar(updateState.message);
                              }
                            },
                            builder: (context, state) {
                              return PrimaryButton(
                                  onPressed: () {
                                    if (formKey.currentState!.validate()) {
                                      print(UpdateProfileInput(
                                                    name:
                                                        nameController.text.trim(),
                                                    address: addressController.text.trim(),
                                                    city: cityController.text.trim(),
                                          mobile: phoneController.text
                                                        .trim()).toJson());
                                      context.read<UpdateProfileCubit>()
                                        ..updateProfile(
                                            UpdateProfileInput(
                                                name:
                                                    nameController.text.trim(),
                                                address: addressController.text.trim(),
                                                city: cityController.text.trim(),
                                                mobile: phoneController.text
                                                    .trim()),
                                            imagePickerState.file);
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
        ),
      ),
    );
  }
}
