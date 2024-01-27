import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:mobile_customer/data/repositories/schedule_repository_impl.dart';
import 'package:mobile_customer/domain/entities/active_schedule/active_schedule_entity/active_schedule_entity.dart';
import 'package:mobile_customer/domain/use_cases/schedule_use_case.dart';

part 'schedule_state.dart';

class ScheduleCubit extends Cubit<ScheduleState> {
  final ScheduleRepositoryImpl repository = ScheduleRepositoryImpl();
  ScheduleCubit() : super(const ScheduleState());

  FutureOr<void> getActiveSchedule() async {
    ScheduleUseCase scheduleUseCase = ScheduleUseCase(repository);

    emit(state.copyWith(isLoading: true));
    var payload = <String, dynamic>{};

    scheduleUseCase.getActiveSchedule(payload).then((res) {
      res.fold(
        (err) => emit(
          state.copyWith(
            errorMsg: err.msg.toString(),
            isLoading: false,
          ),
        ),
        (data) => emit(
          state.copyWith(
              isLoading: false, errorMsg: '', listActiveSchedule: data),
        ),
      );
    });
  }
}
