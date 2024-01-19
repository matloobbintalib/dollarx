import 'package:dollarx/modules/dashboard/pages/dashboard_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:dollarx/config/config.dart';
import 'package:dollarx/constants/app_colors.dart';
import 'package:dollarx/modules/authentication/models/login_input.dart';
import 'package:dollarx/modules/authentication/pages/forgot_password_page.dart';
import 'package:dollarx/modules/authentication/pages/register_page.dart';
import 'package:dollarx/modules/authentication/pages/reset_password_page.dart';
import 'package:dollarx/modules/authentication/widgets/password_suffix_widget.dart';
import 'package:dollarx/modules/home/pages/home_page.dart';
import 'package:dollarx/ui/widgets/base_scaffold.dart';
import 'package:dollarx/ui/widgets/on_click.dart';
import 'package:dollarx/utils/utils.dart';
import '../../../constants/asset_paths.dart';
import '../../../core/core.dart';
import '../../../ui/input/input_field.dart';
import '../../../ui/widgets/primary_button.dart';
import '../../../ui/widgets/toast_loader.dart';
import '../cubits/login/login_cubit.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginCubit(authRepository: sl()),
      child: LoginView(),
    );
  }
}

class LoginView extends StatefulWidget {
  LoginView({Key? key}) : super(key: key);

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: AppColors.black,
      statusBarIconBrightness: Brightness.light, // For Android (dark icons)
      statusBarBrightness: Brightness.light,
    ));
    return BlocConsumer<LoginCubit, LoginState>(
      listener: (context, state) async {
        if (state.loginStatus == LoginStatus.loading) {
          ToastLoader.show();
        } else if (state.loginStatus == LoginStatus.success) {
          ToastLoader.remove();
          NavRouter.push(context, DashboardPage());
        } else if (state.loginStatus == LoginStatus.error) {
          ToastLoader.remove();
          context.showSnackBar(state.message);
        }
      },
      builder: (context, state) {
        return BaseScaffold(
          safeAreaTop: true,
          body: SingleChildScrollView(
            child: Form(
              key: formKey,
              child: Column(
                children: [
                  SizedBox(
                    height: 50,
                  ),
                  Image.asset(
                    AssetPaths.logoPng,
                    width: 120,
                    height: 120,
                  ),
                  SizedBox(
                    height: 24,
                  ),
                  Text(
                    "Login Account",
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
                        context.read<LoginCubit>().toggleShowPassword();
                      },
                    ),
                    obscureText: !state.isPasswordHidden,
                  ),
                  Align(
                    child: OnClick(
                      onTap: () {
                        NavRouter.push(context, ForgotPasswordPage());
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          "Forgot Password?",
                          style: context.textTheme.bodySmall?.copyWith(
                              color: AppColors.secondary,
                              decoration: TextDecoration.underline,
                              decorationColor: context.colorScheme.onSecondary,
                              decorationThickness: 1,
                              height: 2),
                          textAlign: TextAlign.start,
                        ),
                      ),
                    ),
                    alignment: Alignment.centerRight,
                  ),
                  SizedBox(
                    height: 60,
                  ),
                  PrimaryButton(onPressed: _onLoggedIn, title: 'Login'),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      OnClick(
                          onTap: () {
                            NavRouter.push(context, RegisterPage());
                          },
                          child: Text("Register?",
                              style: context.textTheme.bodyMedium?.copyWith(
                                  color: AppColors.secondary,
                                  decoration: TextDecoration.underline,
                                  decorationColor:
                                      context.colorScheme.onSecondary,
                                  decorationThickness: 1.5,
                                  height: 3))),
                      SizedBox(
                        width: 6,
                      ),
                      Text("for free",
                          style: context.textTheme.bodyMedium
                              ?.copyWith(height: 3)),
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

  void _onLoggedIn() {
    if (formKey.currentState!.validate()) {
      context.read<LoginCubit>().login(LoginInput(
          email: emailController.text.trim(),
          password: passwordController.text.trim()));
    }
  }
}
