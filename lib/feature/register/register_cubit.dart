import 'dart:async';

import 'package:bloc/bloc.dart';

import 'package:equatable/equatable.dart';
import 'package:mobile_customer/core/routes/app_router.dart';
import 'package:mobile_customer/data/repositories/auth_repository_impl.dart';

import 'package:mobile_customer/domain/entities/register/register_entity.dart';
import 'package:mobile_customer/domain/use_cases/auth_use_case.dart';

import 'package:mobile_customer/main.dart';

part 'register_state.dart';

class RegisterCubit extends Cubit<RegisterState> {
  final AuthRepositoryImpl repository = AuthRepositoryImpl();

  RegisterCubit() : super(const RegisterState());

  FutureOr<void> register(Map<String, dynamic> registerRequest) async {
    emit(
      state.copyWith(isLoading: true),
    );

    AuthUseCase registerUseCase = AuthUseCase(repository);

    registerUseCase.register(registerRequest).then((res) {
      res.fold((err) {
        emit(state.copyWith(
          isLoading: false,
          errorMsg: err.msg,
        ));
      }, (data) {
        emit(state.copyWith(isLoading: false, errorMsg: '', data: data));
        MyApp.router.replace(const LoginRoute());
      });
    });
  }
}
