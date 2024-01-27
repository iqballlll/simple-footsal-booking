import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:mobile_customer/data/repositories/home_repository_impl.dart';
import 'package:mobile_customer/domain/entities/schedule_entity.dart/schedule_entity/schedule_entity.dart';
import 'package:mobile_customer/domain/repositories/home_repository.dart';
import 'package:mobile_customer/domain/use_cases/home_use_case.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  final HomeRepository repository = HomeRepositoryImpl();
  HomeCubit() : super(const HomeState());

  FutureOr<void> getSchedule() async {
    emit(state.copyWith(isLoading: true));

    HomeUseCase homeUseCase = HomeUseCase(repository);

    await homeUseCase.getSchedule().then((res) {
      res.fold(
        (err) => emit(
          state.copyWith(
            errorMsg: err.msg.toString(),
            isLoading: false,
          ),
        ),
        (data) {
          emit(state.copyWith(
              isLoading: false, errorMsg: '', listSchedule: data));
        },
      );
    });
  }

  FutureOr<void> getCountOrder() async {
    emit(state.copyWith(isLoading: true));

    HomeUseCase homeUseCase = HomeUseCase(repository);

    await homeUseCase.getCountOrder().then((res) {
      res.fold(
        (err) => emit(
          state.copyWith(
            errorMsg: err.msg.toString(),
            isLoading: false,
          ),
        ),
        (data) {
          emit(
              state.copyWith(isLoading: false, errorMsg: '', countOrder: data));
        },
      );
    });
  }

  void onLoading() {
    emit(state.copyWith(isLoading: true));
  }
}
