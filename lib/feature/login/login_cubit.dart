import 'dart:async';
import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:mobile_customer/core/routes/app_router.dart';
import 'package:mobile_customer/data/local/local_data_source.dart';
import 'package:mobile_customer/data/repositories/auth_repository_impl.dart';

import 'package:mobile_customer/domain/entities/login/login_entity.dart';
import 'package:mobile_customer/domain/use_cases/auth_use_case.dart';

import 'package:mobile_customer/main.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  final AuthRepositoryImpl repository = AuthRepositoryImpl();
  LoginCubit() : super(const LoginState());

  FutureOr<void> login(Map<String, dynamic> loginRequest) async {
    emit(state.copyWith(
      isLoading: true,
    ));

    AuthUseCase authUseCase = AuthUseCase(repository);

    authUseCase.login(loginRequest).then((res) {
      res.fold((err) {
        emit(state.copyWith(
          errorMsg: err.msg.toString(),
          isLoading: false,
        ));
      }, (resLogin) async {
        await LocalDataSource.store(
            key: 'token', value: resLogin.token.toString());

        authUseCase.getProfile().then((res) {
          res.fold(
              (err) => emit(state.copyWith(
                    errorMsg: err.msg.toString(),
                    isLoading: false,
                  )), (resGetProfile) async {
            await LocalDataSource.store(
                key: 'profile', value: jsonEncode(resGetProfile));

            emit(state.copyWith(isLoading: false, errorMsg: ''));
            MyApp.router.replace(const MainRoute());
          });
        });
      });
    });
  }
}
