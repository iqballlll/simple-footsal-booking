import 'dart:convert';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_customer/core/components/custom_button.dart';
import 'package:mobile_customer/core/components/custom_text_field.dart';
import 'package:mobile_customer/core/requests/change_profile/change_profile_request.dart';
import 'package:mobile_customer/core/requests/change_profile/change_profile_validation.dart';
import 'package:mobile_customer/core/utilities/app_helper.dart';
import 'package:mobile_customer/core/utilities/enums/snackbar_enum.dart';
import 'package:mobile_customer/core/utilities/extension.dart';
import 'package:mobile_customer/core/utilities/style.dart';
import 'package:mobile_customer/data/local/local_data_source.dart';
import 'package:mobile_customer/domain/entities/profile/profile_entity.dart';
import 'package:mobile_customer/feature/change_profile/change_profile_cubit.dart';
import 'package:mobile_customer/feature/profile/profile_cubit.dart';

@RoutePage()
class ChangeProfileScreen extends StatelessWidget {
  const ChangeProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ChangeProfileCubit(),
      child: const _ContentChangeProfileScreen(),
    );
  }
}

class _ContentChangeProfileScreen extends StatefulWidget {
  const _ContentChangeProfileScreen();

  @override
  State<_ContentChangeProfileScreen> createState() =>
      _ContentChangeProfileScreenState();
}

class _ContentChangeProfileScreenState
    extends State<_ContentChangeProfileScreen> {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  String name = '';
  String phone = '';
  String email = '';
  String address = '';
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await LocalDataSource.get(key: "profile").then((value) {
        var profileEntity = ProfileEntity.fromJson(jsonDecode(value!));
        nameController.text = (profileEntity.name ?? '');
        emailController.text = (profileEntity.email ?? '');
        phoneController.text = (profileEntity.phone ?? '');
        addressController.text = (profileEntity.address ?? '');
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<ChangeProfileCubit, ChangeProfileState>(
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
            "Ubah Profil",
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
                    controller: nameController,
                    hintText: "Nama",
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  CustomTextField(
                    controller: emailController,
                    hintText: "Email",
                    keyboardType: TextInputType.emailAddress,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  CustomTextField(
                    controller: phoneController,
                    hintText: "No Telepon",
                    keyboardType: TextInputType.phone,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  CustomTextField(
                    controller: addressController,
                    hintText: "Alamat",
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  BlocBuilder<ChangeProfileCubit, ChangeProfileState>(
                    builder: (context, state) {
                      return CustomButton(
                        isLoading: state.isLoading,
                        onPressed: () {
                          ChangeProfileRequest changeProfileRequest =
                              ChangeProfileRequest(
                                  name: nameController.text,
                                  email: emailController.text,
                                  phone: phoneController.text,
                                  address: addressController.text);

                          // String validation = ChangeProfileValidation.validate(
                          //     changeProfileRequest);

                          // if (validation.isNotEmpty) {
                          //   AppHelper.customSnackBar(
                          //       context, validation, SnackBarEnum.error);
                          //   return;
                          // }
                          context
                              .read<ChangeProfileCubit>()
                              .changeProfile(changeProfileRequest.toMap());
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
