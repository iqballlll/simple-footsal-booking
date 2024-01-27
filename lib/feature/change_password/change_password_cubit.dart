import 'dart:async';

import 'package:bloc/bloc.dart';

import 'package:equatable/equatable.dart';
import 'package:mobile_customer/data/repositories/auth_repository_impl.dart';

import 'package:mobile_customer/domain/use_cases/auth_use_case.dart';
import 'package:mobile_customer/main.dart';

part 'change_password_state.dart';

class ChangePasswordCubit extends Cubit<ChangePasswordState> {
  AuthRepositoryImpl repository = AuthRepositoryImpl();
  ChangePasswordCubit() : super(const ChangePasswordState());

  FutureOr<void> updatePassword(Map<String, dynamic> payload) {
    AuthUseCase authUseCase = AuthUseCase(repository);

    authUseCase.updatePassword(payload).then(
          (res) => res.fold(
            (err) => emit(
              state.copyWith(
                isLoading: false,
                errorMsg: err.msg.toString(),
                isSuccessUpdate: false,
              ),
            ),
            (data) {
              emit(
                state.copyWith(
                  isLoading: false,
                  errorMsg: '',
                  isSuccessUpdate: true,
                ),
              );
              MyApp.router.pop();
            },
          ),
        );
  }
}
