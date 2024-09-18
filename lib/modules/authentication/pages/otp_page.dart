import 'package:dollarax/modules/authentication/pages/reset_password_page.dart';
import 'package:dollarax/modules/dashboard/pages/dashboard_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dollarax/config/config.dart';
import 'package:dollarax/constants/app_colors.dart';
import 'package:dollarax/modules/authentication/cubits/forgot_password/forgot_password_cubit.dart';
import 'package:dollarax/modules/authentication/cubits/forgot_password/forgot_password_state.dart';
import 'package:dollarax/modules/authentication/cubits/verify_otp/verify_otp_cubit.dart';
import 'package:dollarax/modules/authentication/cubits/verify_otp/verify_otp_state.dart';
import 'package:dollarax/modules/authentication/models/forgot_password_input.dart';
import 'package:dollarax/modules/authentication/models/verify_otp_input.dart';
import 'package:dollarax/ui/widgets/base_scaffold.dart';
import 'package:dollarax/utils/display/display_utils.dart';
import 'package:dollarax/utils/utils.dart';
import 'package:otp_text_field/otp_field.dart';
import 'package:otp_text_field/otp_field_style.dart';
import 'package:otp_text_field/style.dart';
import '../../../core/core.dart';
import '../../../ui/widgets/custom_appbar.dart';
import '../../../ui/widgets/on_click.dart';
import '../../../ui/widgets/primary_button.dart';
import '../../../ui/widgets/toast_loader.dart';
import 'login_page.dart';

class OtpPage extends StatelessWidget {
  final bool isFromRegister;
  final String email;

  const OtpPage({super.key, required this.email, required this.isFromRegister});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => VerifyOtpCubit(authRepository: sl()),
        ),
        BlocProvider(
          create: (context) => ForgotPasswordCubit(authRepository: sl()),
        ),
      ],
      child: OtpPageView(
        email: email,
        isFromRegister: isFromRegister,
      ),
    );
  }
}

class OtpPageView extends StatefulWidget {
  final String email;
  final bool isFromRegister;

  OtpPageView({Key? key, required this.email, required this.isFromRegister}) : super(key: key);

  @override
  State<OtpPageView> createState() => _OtpPageViewState();
}

class _OtpPageViewState extends State<OtpPageView> {
  String otpValue = "";
  OtpFieldController otpController = OtpFieldController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<VerifyOtpCubit, VerifyOtpState>(
      listener: (context, state) async {
        if (state.verifyOtpStatus == VerifyOtpStatus.loading) {
          ToastLoader.show();
        } else if (state.verifyOtpStatus == VerifyOtpStatus.success) {
          ToastLoader.remove();
          DisplayUtils.showToast(context, state.message);
          if(widget.isFromRegister){
            NavRouter.pushAndRemoveUntil(context, DashboardPage());
          }else{
            NavRouter.push(context, ResetPasswordPage());
          }
        } else if (state.verifyOtpStatus == VerifyOtpStatus.error) {
          ToastLoader.remove();
          DisplayUtils.showToast(context, state.message);
        }
      },
      builder: (context, state) {
        return BaseScaffold(
          safeAreaTop: true,
          appBar: CustomAppbar(
            title: 'OTP Authentication',
          ),
          body: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: 50,
                ),
                Text(
                  "Enter OTP",
                  style: context.textTheme.headlineSmall?.copyWith(
                      color: AppColors.secondary, fontWeight: FontWeight.w600),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  "A verification code has been dispatched to you at\nyour email address",
                  style: context.textTheme.bodySmall,
                  textAlign: TextAlign.center,
                ),
                SizedBox(
                  height: 60,
                ),
                Align(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: Text(
                      "Enter Otp",
                      style: context.textTheme.bodyMedium,
                      textAlign: TextAlign.start,
                    ),
                  ),
                  alignment: Alignment.centerLeft,
                ),
                SizedBox(
                  height: 8,
                ),
                OTPTextField(
                  length: 6,
                  controller: otpController,
                  width: MediaQuery.of(context).size.width,
                  fieldWidth: 50,
                  outlineBorderRadius: 6,
                  style: TextStyle(fontSize: 17, color: Colors.white),
                  keyboardType: TextInputType.number,
                  textFieldAlignment: MainAxisAlignment.spaceEvenly,
                  fieldStyle: FieldStyle.box,
                  otpFieldStyle: OtpFieldStyle(
                      backgroundColor: AppColors.fieldColor,
                      borderColor: AppColors.secondary,
                      enabledBorderColor: AppColors.secondary,
                      errorBorderColor: AppColors.red),
                  onCompleted: (pin) {
                    setState(() {
                      otpValue = pin;
                    });
                  },
                ),
                Align(
                  child: BlocConsumer<ForgotPasswordCubit, ForgotPasswordState>(
                    listener: (context, forgotPasswordState) {
                      if (forgotPasswordState.forgotPasswordStatus ==
                          ForgotPasswordStatus.loading) {
                        ToastLoader.show();
                      } else if (forgotPasswordState.forgotPasswordStatus ==
                          ForgotPasswordStatus.success) {
                        ToastLoader.remove();
                        DisplayUtils.showToast(
                            context, state.message);
                      } else if (forgotPasswordState.forgotPasswordStatus ==
                          ForgotPasswordStatus.error) {
                        ToastLoader.remove();
                        DisplayUtils.showToast(context, state.message);
                      }
                    },
                    builder: (context, state) {
                      return OnClick(
                        onTap: () {
                          otpController.clear();
                          context.read<ForgotPasswordCubit>()
                            ..forgotPassword(
                                ForgotPasswordInput(email: widget.email));
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            "Resend Code?",
                            style: context.textTheme.bodySmall?.copyWith(
                                color: AppColors.secondary,
                                decoration: TextDecoration.underline,
                                decorationColor:
                                    context.colorScheme.onSecondary,
                                decorationThickness: 1,
                                height: 2),
                            textAlign: TextAlign.start,
                          ),
                        ),
                      );
                    },
                  ),
                  alignment: Alignment.centerRight,
                ),
                SizedBox(
                  height: 230,
                ),
                PrimaryButton(onPressed: _onVerifyOtp, title: 'Submit'),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Back to",
                        style:
                            context.textTheme.bodyMedium?.copyWith(height: 3)),
                    SizedBox(
                      width: 6,
                    ),
                    OnClick(
                        onTap: () {
                          NavRouter.push(context, LoginPage());
                        },
                        child: Text("Login",
                            style: context.textTheme.bodyMedium?.copyWith(
                                color: AppColors.secondary,
                                decoration: TextDecoration.underline,
                                decorationColor:
                                    context.colorScheme.onSecondary,
                                decorationThickness: 1.5,
                                height: 3))),
                  ],
                )
              ],
            ),
          ),
        );
      },
    );
  }

  void _onVerifyOtp() {
    if (otpValue.isNotEmpty) {
      context
          .read<VerifyOtpCubit>()
          .verifyOtp(VerifyOtpInput(email: widget.email, otp: otpValue.toString()));
    } else {
      DisplayUtils.showToast(context,"Enter OTP");
    }
  }
}
