import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:mobile_customer/core/routes/app_router.dart';
import 'package:mobile_customer/data/local/local_data_source.dart';
import 'package:mobile_customer/data/repositories/auth_repository_impl.dart';
import 'package:mobile_customer/domain/use_cases/auth_use_case.dart';
import 'package:mobile_customer/main.dart';

part 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit() : super(const ProfileState());
  final AuthRepositoryImpl repository = AuthRepositoryImpl();

  FutureOr<void> logout() async {
    AuthUseCase authUseCase = AuthUseCase(repository);

    emit(state.copyWith(isLoading: true));

    authUseCase.logout().then((res) {
      res.fold(
          (err) => emit(
                state.copyWith(errorMsg: err.msg.toString(), isLoading: false),
              ), (data) async {
        emit(state.copyWith(errorMsg: '', isLoading: false));
        await LocalDataSource.delete(key: "token");

        MyApp.router.replace(const LoginRoute());
      });
    });
  }
}
