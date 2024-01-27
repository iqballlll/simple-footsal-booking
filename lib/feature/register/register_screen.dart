import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_customer/core/components/custom_text_field.dart';
import 'package:mobile_customer/core/requests/register/register_request.dart';
import 'package:mobile_customer/core/requests/register/register_validation.dart';
import 'package:mobile_customer/core/utilities/app_helper.dart';
import 'package:mobile_customer/core/utilities/enums/snackbar_enum.dart';
import 'package:mobile_customer/core/utilities/extension.dart';
import 'package:mobile_customer/core/utilities/style.dart';
import 'package:mobile_customer/feature/register/register_cubit.dart';

@RoutePage()
class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final nameController = TextEditingController();
  final phoneController = TextEditingController();
  final emailController = TextEditingController();
  final addressController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => RegisterCubit(),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.primary,
          elevation: 1,
          title: Text(
            'Daftar',
            style: Style.title(context).copyWith(color: Colors.white),
          ),
          actions: [
            BlocBuilder<RegisterCubit, RegisterState>(
              buildWhen: (previous, current) =>
                  previous.isLoading != current.isLoading,
              builder: (context, state) {
                return IconButton(
                  onPressed: () {
                    RegisterRequest registerRequest = RegisterRequest(
                      name: nameController.text,
                      email: emailController.text,
                      phone: phoneController.text,
                      address: addressController.text,
                      password: passwordController.text,
                      confirmPassword: confirmPasswordController.text,
                    );
                    var validation =
                        RegisterValidation.validate(registerRequest);
                    if (validation.isNotEmpty) {
                      AppHelper.customSnackBar(
                          context, validation, SnackBarEnum.error);
                      return;
                    }
                    context
                        .read<RegisterCubit>()
                        .register(registerRequest.toMap());
                  },
                  icon: state.isLoading.isTrue
                      ? SizedBox.fromSize(
                          size: const Size(25, 25),
                          child: const CircularProgressIndicator(
                            strokeWidth: 3,
                            color: Colors.white,
                          ),
                        )
                      : const Icon(
                          Icons.check,
                          size: 30,
                        ),
                );
              },
            )
          ],
        ),
        body: GestureDetector(
          onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
          child: SingleChildScrollView(
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CustomTextField(
                    controller: nameController,
                    hintText: "Nama",
                  ),
                  const SizedBox(height: 20),
                  CustomTextField(
                    controller: emailController,
                    hintText: "Email",
                  ),
                  const SizedBox(height: 20),
                  CustomTextField(
                    controller: phoneController,
                    hintText: "Nomor Telepon",
                  ),
                  const SizedBox(height: 20),
                  CustomTextField(
                    controller: addressController,
                    hintText: "Alamat",
                    maxLines: 2,
                  ),
                  const SizedBox(height: 20),
                  CustomTextField(
                    controller: passwordController,
                    showPassword: true,
                    hintText: "Password",
                  ),
                  const SizedBox(height: 20),
                  CustomTextField(
                    controller: confirmPasswordController,
                    showPassword: true,
                    hintText: "Konfirmasi Password",
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
