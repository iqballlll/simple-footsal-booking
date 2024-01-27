import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_customer/core/components/custom_button.dart';
import 'package:mobile_customer/core/components/custom_text_field.dart';
import 'package:mobile_customer/core/requests/change_password/change_password_request.dart';
import 'package:mobile_customer/core/requests/change_password/change_profile_validation.dart';
import 'package:mobile_customer/core/utilities/app_helper.dart';
import 'package:mobile_customer/core/utilities/enums/snackbar_enum.dart';
import 'package:mobile_customer/core/utilities/extension.dart';
import 'package:mobile_customer/core/utilities/style.dart';
import 'package:mobile_customer/feature/change_password/change_password_cubit.dart';

@RoutePage()
class ChangePasswordScreen extends StatelessWidget {
  const ChangePasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ChangePasswordCubit(),
      child: const _ContentChangePaswordScreen(),
    );
  }
}

class _ContentChangePaswordScreen extends StatefulWidget {
  const _ContentChangePaswordScreen();

  @override
  State<_ContentChangePaswordScreen> createState() =>
      __ContentChangePaswordScreenState();
}

class __ContentChangePaswordScreenState
    extends State<_ContentChangePaswordScreen> {
  TextEditingController oldPwdController = TextEditingController();
  TextEditingController newPwdController = TextEditingController();
  TextEditingController confPwdController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocListener<ChangePasswordCubit, ChangePasswordState>(
      listener: (context, state) {
        if (state.errorMsg.isNotEmpty) {
          AppHelper.customSnackBar(context, state.errorMsg, SnackBarEnum.error);
        }
        if (state.isSuccessUpdate.isTrue) {
          AppHelper.customSnackBar(context, "Sukses", SnackBarEnum.success);
        }
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.primary,
          title: Text(
            "Ubah Password",
            style: Style.title(context).copyWith(color: Colors.white),
          ),
          leading: const BackButton(color: Colors.white),
        ),
        body: GestureDetector(
          onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  CustomTextField(
                    controller: oldPwdController,
                    hintText: "Password Lama",
                    showPassword: true,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  CustomTextField(
                    controller: newPwdController,
                    hintText: "Password Baru",
                    showPassword: true,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  CustomTextField(
                    controller: confPwdController,
                    hintText: "Password Konfirmasi Baru",
                    showPassword: true,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  BlocBuilder<ChangePasswordCubit, ChangePasswordState>(
                    builder: (context, state) {
                      return CustomButton(
                        isLoading: state.isLoading,
                        onPressed: () {
                          ChangePasswordRequest changePasswordRequest =
                              ChangePasswordRequest(
                            oldPassword: oldPwdController.text,
                            newPassword: newPwdController.text,
                            confirmPassword: confPwdController.text,
                          );

                          String validation = ChangePasswordValidation.validate(
                              changePasswordRequest);

                          if (validation.isNotEmpty) {
                            AppHelper.customSnackBar(
                                context, validation, SnackBarEnum.error);
                            return;
                          }
                          context
                              .read<ChangePasswordCubit>()
                              .updatePassword(changePasswordRequest.toMap());
                        },
                        title: "Update",
                        titleStyle: Style.body1(context),
                      );
                    },
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
