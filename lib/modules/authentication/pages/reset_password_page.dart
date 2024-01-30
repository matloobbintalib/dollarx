import 'package:dollarx/utils/display/display_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dollarx/config/config.dart';
import 'package:dollarx/constants/app_colors.dart';
import 'package:dollarx/modules/authentication/cubits/reset_password/reset_password_cubit.dart';
import 'package:dollarx/modules/authentication/cubits/reset_password/reset_password_state.dart';
import 'package:dollarx/modules/authentication/models/reset_password_input.dart';
import 'package:dollarx/modules/authentication/widgets/password_suffix_widget.dart';
import 'package:dollarx/ui/widgets/base_scaffold.dart';
import 'package:dollarx/ui/widgets/on_click.dart';
import 'package:dollarx/utils/utils.dart';
import '../../../core/core.dart';
import '../../../ui/input/input_field.dart';
import '../../../ui/widgets/custom_appbar.dart';
import '../../../ui/widgets/primary_button.dart';
import '../../../ui/widgets/toast_loader.dart';
import 'login_page.dart';

class ResetPasswordPage extends StatelessWidget {
  const ResetPasswordPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ResetPasswordCubit(authRepository: sl()),
      child: ResetPasswordPageView(),
    );
  }
}

class ResetPasswordPageView extends StatefulWidget {
  ResetPasswordPageView({Key? key}) : super(key: key);

  @override
  State<ResetPasswordPageView> createState() => _ResetPasswordPageViewState();
}

class _ResetPasswordPageViewState extends State<ResetPasswordPageView> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ResetPasswordCubit, ResetPasswordState>(
      listener: (context, state) async {
        if (state.resetPasswordStatus == ResetPasswordStatus.loading) {
          ToastLoader.show();
        } else if (state.resetPasswordStatus == ResetPasswordStatus.success) {
          ToastLoader.remove();
          DisplayUtils.showToast(context, state.message);
          NavRouter.push(context, LoginPage());
        } else if (state.resetPasswordStatus == ResetPasswordStatus.error) {
          ToastLoader.remove();
          context.showSnackBar(state.message);
        }
      },
      builder: (context, state) {
        return BaseScaffold(
          safeAreaTop: true,
          appBar: CustomAppbar(
            title: 'Reset Password',
          ),
          body: SingleChildScrollView(
            child: Form(
              key: formKey,
              child: Column(
                children: [
                  SizedBox(height: 50,),
                  Text("Reset Password",style: context.textTheme.headlineSmall?.copyWith(color: AppColors.secondary,  fontWeight: FontWeight.w600),),
                  SizedBox(height: 10,),
                  Text("A verification code has been dispatched to you at\nyour email address",style: context.textTheme.bodySmall,textAlign: TextAlign.center,),
                  SizedBox(
                    height: 60,
                  ),
                  Align(child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: Text("Email",style: context.textTheme.bodyMedium,textAlign: TextAlign.start,),
                  ),alignment: Alignment.centerLeft,),
                  SizedBox(height: 8,),
                  InputField.email(
                    controller: emailController,
                    label: "Type Your Email",
                  ),
                  SizedBox(
                    height: 24,
                  ),
                  Align(child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: Text("Password",style: context.textTheme.bodyMedium,textAlign: TextAlign.start,),
                  ),alignment: Alignment.centerLeft,),
                  SizedBox(height: 8,),
                  InputField.password(
                    controller: passwordController,
                    label: "Type Your Password",
                    suffixIcon: PasswordSuffixIcon(
                      isPasswordVisible: state.isPasswordHidden,
                      onTap: () {
                        context.read<ResetPasswordCubit>().toggleShowPassword();
                      },
                    ),
                    obscureText: !state.isPasswordHidden,
                  ),
                  SizedBox(
                    height: 24,
                  ),
                  Align(child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: Text("Confirm Password",style: context.textTheme.bodyMedium,textAlign: TextAlign.start,),
                  ),alignment: Alignment.centerLeft,),
                  SizedBox(height: 8,),
                  InputField.confirmPassword(
                    controller: confirmPasswordController,
                    label: "Type Your Confirm Password",
                    suffixIcon: PasswordSuffixIcon(
                      isPasswordVisible: state.isConfirmPasswordHidden,
                      onTap: () {
                        context.read<ResetPasswordCubit>().toggleShowConfirmPassword();
                      },
                    ),
                    obscureText: !state.isConfirmPasswordHidden, confirmPasswordController: passwordController, onFieldSubmitted: (String value) {

                  },
                  ),
                  SizedBox(
                    height: 200,
                  ),
                  PrimaryButton(onPressed: _onResetPassword, title: 'Submit'),
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

  void _onResetPassword() {
    if(formKey.currentState!.validate()){
      context.read<ResetPasswordCubit>().resetPassword(ResetPasswordInput(email: emailController.text.trim(), password: passwordController.text.trim(), confirm_password: confirmPasswordController.text.trim()));
    }
  }
}
