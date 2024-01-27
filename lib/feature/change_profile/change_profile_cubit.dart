import 'dart:async';
import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:mobile_customer/data/local/local_data_source.dart';
import 'package:mobile_customer/data/repositories/auth_repository_impl.dart';
import 'package:mobile_customer/domain/entities/change_profile/change_profile_entity.dart';
import 'package:mobile_customer/domain/use_cases/auth_use_case.dart';
import 'package:mobile_customer/main.dart';

part 'change_profile_state.dart';

class ChangeProfileCubit extends Cubit<ChangeProfileState> {
  AuthRepositoryImpl repository = AuthRepositoryImpl();
  ChangeProfileCubit() : super(const ChangeProfileState());

  FutureOr<void> changeProfile(Map<String, dynamic> payload) async {
    AuthUseCase authUseCase = AuthUseCase(repository);

    // emit(state.copyWith(isLoading: true));

    authUseCase.updateProfile(payload).then(
          (res) => res.fold(
            (err) => emit(
              state.copyWith(
                isLoading: false,
                errorMsg: err.msg.toString(),
              ),
            ),
            (resUpdate) async {
              authUseCase.getProfile().then((res) {
                res.fold(
                    (err) => emit(state.copyWith(
                          errorMsg: err.msg.toString(),
                          isLoading: false,
                        )), (resGetProfile) async {
                  await LocalDataSource.store(
                      key: 'profile', value: jsonEncode(resGetProfile));

                  emit(state.copyWith(
                      isSuccessUpdate: true, isLoading: false, errorMsg: ''));

                  MyApp.router.pop({"username": payload['name']});
                });
              });
            },
          ),
        );
  }
}
