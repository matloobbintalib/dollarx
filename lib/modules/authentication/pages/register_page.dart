import 'package:dollarx/modules/authentication/pages/otp_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dollarx/config/config.dart';
import 'package:dollarx/constants/app_colors.dart';
import 'package:dollarx/modules/authentication/cubits/register/register_cubit.dart';
import 'package:dollarx/modules/authentication/models/register_input.dart';
import 'package:dollarx/modules/authentication/pages/login_page.dart';
import 'package:dollarx/modules/authentication/widgets/password_suffix_widget.dart';
import 'package:dollarx/ui/widgets/base_scaffold.dart';
import 'package:dollarx/ui/widgets/on_click.dart';
import 'package:dollarx/utils/utils.dart';
import '../../../core/core.dart';
import '../../../ui/input/input_field.dart';
import '../../../ui/widgets/custom_appbar.dart';
import '../../../ui/widgets/primary_button.dart';
import '../../../ui/widgets/toast_loader.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => RegisterCubit(authRepository: sl()),
      child: RegisterPageView(),
    );
  }
}

class RegisterPageView extends StatefulWidget {
  RegisterPageView({Key? key}) : super(key: key);

  @override
  State<RegisterPageView> createState() => _RegisterPageViewState();
}

class _RegisterPageViewState extends State<RegisterPageView> {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController parentIdController = TextEditingController();
  TextEditingController mobileController = TextEditingController();
  TextEditingController confirmPasswordController =
      TextEditingController();

  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<RegisterCubit, RegisterState>(
      listener: (context, state) async {
        if (state.registerStatus == RegisterStatus.loading) {
          ToastLoader.show();
        } else if (state.registerStatus == RegisterStatus.success) {
          ToastLoader.remove();
          NavRouter.push(context, OtpPage(email: emailController.text.trim(), isFromRegister: true,));
        } else if (state.registerStatus == RegisterStatus.error) {
          ToastLoader.remove();
          context.showSnackBar(state.message);
        }
      },
      builder: (context, state) {
        return BaseScaffold(
          safeAreaTop: true,
          appBar: CustomAppbar(
            title: 'Register',
          ),
          body: Form(
            key: formKey,
            autovalidateMode: state.isAutoValidate
                ? AutovalidateMode.always
                : AutovalidateMode.disabled,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(
                    height: 50,
                  ),
                  Text(
                    "Getting Started",
                    style: context.textTheme.headlineSmall?.copyWith(
                        color: AppColors.secondary,
                        fontWeight: FontWeight.w600),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    "A DollarAx login is a secure authentication process\nthat enables users to access",
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
                    height: 24,
                  ),
                  Align(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
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
                  InputField.email(
                    controller: emailController,
                    label: "Type Your Email",
                  ),
                  SizedBox(
                    height: 24,
                  ),
                  Align(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      child: Text(
                        "Mobile",
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
                    controller: mobileController,
                    label: "Type Your Mobile Number",
                  ),
                  Align(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      child: Text(
                        "Referral ID",
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
                    controller: parentIdController,
                    label: "Type Your Referral",
                  ),
                  SizedBox(
                    height: 24,
                  ),
                  Align(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      child: Text(
                        "Password",
                        style: context.textTheme.bodyMedium,
                        textAlign: TextAlign.start,
                      ),
                    ),
                    alignment: Alignment.centerLeft,
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  InputField.password(
                    controller: passwordController,
                    label: "Type Your Password",
                    suffixIcon: PasswordSuffixIcon(
                      isPasswordVisible: state.isPasswordHidden,
                      onTap: () {
                        context.read<RegisterCubit>().toggleShowPassword();
                      },
                    ),
                    obscureText: !state.isPasswordHidden,
                  ),
                  SizedBox(
                    height: 24,
                  ),
                  Align(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      child: Text(
                        "Confirm Password",
                        style: context.textTheme.bodyMedium,
                        textAlign: TextAlign.start,
                      ),
                    ),
                    alignment: Alignment.centerLeft,
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  InputField.confirmPassword(
                    controller: confirmPasswordController,
                    label: "Type Your Confirm Password",
                    suffixIcon: PasswordSuffixIcon(
                      isPasswordVisible: state.isConfirmPasswordHidden,
                      onTap: () {
                        context.read<RegisterCubit>().toggleShowConfirmPassword();
                      },
                    ),
                    confirmPasswordController: passwordController,
                    onFieldSubmitted: (String value) {},
                    obscureText: !state.isConfirmPasswordHidden,
                  ),
                  SizedBox(
                    height: 70,
                  ),
                  PrimaryButton(onPressed: _onRegister, title: 'Register'),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Already have an account?",
                          style: context.textTheme.bodyMedium
                              ?.copyWith(height: 3)),
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
          ),
        );
      },
    );
  }

  void _onRegister() {
    if (formKey.currentState!.validate()) {
      context.read<RegisterCubit>().register(RegisterInput(
          name: nameController.text.trim(),
          email: emailController.text.trim(),
          password: passwordController.text.trim(),
          parent_id: parentIdController.text.trim(),
          mobile: mobileController.text.trim(),
          password_confirmation: passwordController.text.trim()));
    }
  }
}
