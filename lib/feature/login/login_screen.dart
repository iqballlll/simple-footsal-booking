import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_customer/core/components/custom_button.dart';
import 'package:mobile_customer/core/components/custom_text_field.dart';
import 'package:mobile_customer/core/requests/login/login_validation.dart';
import 'package:mobile_customer/core/requests/login/login_request.dart';
import 'package:mobile_customer/core/routes/app_router.dart';
import 'package:mobile_customer/core/utilities/app_helper.dart';
import 'package:mobile_customer/core/utilities/constants/asset_constant.dart';
import 'package:mobile_customer/core/utilities/enums/snackbar_enum.dart';
import 'package:mobile_customer/core/utilities/style.dart';
import 'package:mobile_customer/feature/login/login_cubit.dart';

@RoutePage()
class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => LoginCubit(),
      child: const _ContentLoginScreen(),
    );
  }
}

class _ContentLoginScreen extends StatefulWidget {
  const _ContentLoginScreen();

  @override
  State<_ContentLoginScreen> createState() => __ContentLoginScreenState();
}

class __ContentLoginScreenState extends State<_ContentLoginScreen> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    bool isSnackbarShown = false;

    return BlocListener<LoginCubit, LoginState>(
      listenWhen: (previous, current) => previous.errorMsg != current.errorMsg,
      listener: (context, state) {
        if (state.errorMsg.isNotEmpty && !isSnackbarShown) {
          AppHelper.customSnackBar(context, state.errorMsg, SnackBarEnum.error);
          isSnackbarShown = true;
        } else if (state.errorMsg.isEmpty && isSnackbarShown) {
          isSnackbarShown = false;
        }
      },
      child: Scaffold(
        body: GestureDetector(
          onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
          child: SingleChildScrollView(
            child: Container(
              width: AppHelper.sizeW(context),
              height: AppHelper.sizeH(context),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.background,
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      AssetConstant.logo,
                      width: AppHelper.sizeW(context) * .35,
                    ),
                    const SizedBox(height: 20),
                    Text(
                      "Login",
                      style: Style.title(context),
                    ),
                    const SizedBox(height: 20),
                    CustomTextField(
                      controller: emailController,
                      hintText: "Email",
                    ),
                    const SizedBox(height: 20),
                    CustomTextField(
                      controller: passwordController,
                      showPassword: true,
                      hintText: "Password",
                      onEditingComplete: () {
                        LoginRequest loginRequest = LoginRequest(
                            email: emailController.text,
                            password: passwordController.text);

                        context.read<LoginCubit>().login(loginRequest.toMap());
                      },
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    BlocBuilder<LoginCubit, LoginState>(
                      buildWhen: (previous, current) =>
                          previous.isLoading != current.isLoading,
                      builder: (context, state) {
                        return CustomButton(
                          isLoading: state.isLoading,
                          onPressed: () {
                            LoginRequest loginRequest = LoginRequest(
                                email: emailController.text,
                                password: passwordController.text);

                            var validation =
                                LoginValidation.validate(loginRequest);

                            if (validation.isNotEmpty) {
                              AppHelper.customSnackBar(
                                context,
                                validation,
                                SnackBarEnum.error,
                              );
                              return;
                            }

                            context
                                .read<LoginCubit>()
                                .login(loginRequest.toMap());
                          },
                          title: "Masuk",
                          titleStyle: Style.body1(context).copyWith(
                            color: Theme.of(context).scaffoldBackgroundColor,
                          ),
                        );
                      },
                    ),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Belum punya akun ?',
                          style: Style.body1(context),
                        ),
                        TextButton(
                          style: ButtonStyle(
                            shape: MaterialStateProperty.all(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5.0),
                              ),
                            ),
                          ),
                          onPressed: () {
                            context.router.push(const RegisterRoute());
                          },
                          child: Text(
                            'Daftar',
                            style: Style.body1(context).copyWith(
                              color: Theme.of(context).colorScheme.primary,
                            ),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
