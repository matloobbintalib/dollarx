import 'package:dollarx/utils/display/display_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dollarx/config/config.dart';
import 'package:dollarx/constants/app_colors.dart';
import 'package:dollarx/modules/authentication/models/forgot_password_input.dart';
import 'package:dollarx/modules/authentication/pages/otp_page.dart';
import 'package:dollarx/ui/widgets/base_scaffold.dart';
import 'package:dollarx/ui/widgets/on_click.dart';
import 'package:dollarx/utils/utils.dart';
import '../../../core/core.dart';
import '../../../ui/input/input_field.dart';
import '../../../ui/widgets/custom_appbar.dart';
import '../../../ui/widgets/primary_button.dart';
import '../../../ui/widgets/toast_loader.dart';
import '../cubits/forgot_password/forgot_password_cubit.dart';
import '../cubits/forgot_password/forgot_password_state.dart';
import 'login_page.dart';

class ForgotPasswordPage extends StatelessWidget {
  const ForgotPasswordPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ForgotPasswordCubit(authRepository: sl()),
      child: ForgotPasswordPagePageView(),
    );
  }
}

class ForgotPasswordPagePageView extends StatefulWidget {
  ForgotPasswordPagePageView({Key? key}) : super(key: key);

  @override
  State<ForgotPasswordPagePageView> createState() => _ForgotPasswordPagePageViewState();
}

class _ForgotPasswordPagePageViewState extends State<ForgotPasswordPagePageView> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ForgotPasswordCubit, ForgotPasswordState>(
      listener: (context, state) async {
        if (state.forgotPasswordStatus == ForgotPasswordStatus.loading) {
          ToastLoader.show();
        } else if (state.forgotPasswordStatus == ForgotPasswordStatus.success) {
          ToastLoader.remove();
          DisplayUtils.showToast(context, state.message);
          NavRouter.push(context, OtpPage(email: emailController.text.trim(), isFromRegister: false,));
        } else if (state.forgotPasswordStatus == ForgotPasswordStatus.error) {
          ToastLoader.remove();
          context.showSnackBar(state.message);
        }
      },
      builder: (context, state) {
        return BaseScaffold(
          safeAreaTop: true,
          appBar: CustomAppbar(
            title: 'Forgot Password',
          ),
          body: SingleChildScrollView(
            child: Form(
              key: formKey,
              child: Column(
                children: [
                  SizedBox(height: 50,),
                  Text("Forgot Password",style: context.textTheme.headlineSmall?.copyWith(color: AppColors.secondary,  fontWeight: FontWeight.w600),),
                  SizedBox(height: 10,),
                  Text("A verification code has been dispatched to you at\nyour email address",style: context.textTheme.bodySmall,textAlign: TextAlign.center,),
                  SizedBox(
                    height: 60,
                  ), Align(child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: Text("Email",style: context.textTheme.bodyMedium,textAlign: TextAlign.start,),
                  ),alignment: Alignment.centerLeft,),
                  SizedBox(height: 8,),
                  InputField.email(
                    controller: emailController,
                    label: "Type Your Email",
                  ),
                  SizedBox(
                    height: 200,
                  ),
                  PrimaryButton(onPressed: _onForgotPasswordPage, title: 'Submit'),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Back to",style: context.textTheme.bodyMedium?.copyWith( height: 3)),
                      SizedBox(width: 6,),
                      OnClick(onTap: () {
                        NavRouter.push(context, LoginPage());
                      },
                          child: Text("Login",style: context.textTheme.bodyMedium?.copyWith(color : AppColors.secondary,decoration: TextDecoration.underline,decorationColor: context.colorScheme.onSecondary,decorationThickness: 1.5, height: 3) )),
                    ],
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  void _onForgotPasswordPage() {
    if(formKey.currentState!.validate()){
      context.read<ForgotPasswordCubit>().forgotPassword(ForgotPasswordInput(email: emailController.text.trim()));
    }
  }
}
