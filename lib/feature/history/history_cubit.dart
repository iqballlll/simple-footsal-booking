import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:mobile_customer/data/repositories/booking_repository_impl.dart';
import 'package:mobile_customer/domain/entities/history_booking/history_booking_entity/history_booking_entity.dart';
import 'package:mobile_customer/domain/use_cases/booking_use_case.dart';

part 'history_state.dart';

class HistoryCubit extends Cubit<HistoryState> {
  BookingRepositoryImpl repository = BookingRepositoryImpl();
  HistoryCubit() : super(const HistoryState());

  FutureOr<void> getHistoryBooking() async {
    BookingUseCase bookingUseCase = BookingUseCase(repository);

    emit(state.copyWith(isLoading: true));

    bookingUseCase.historyBooking(<String, dynamic>{}).then(
      (res) => res.fold(
        (err) => emit(
          state.copyWith(
            isLoading: false,
            errorMsg: err.msg.toString(),
            listHistoryBooking: [],
          ),
        ),
        (data) {
          emit(state.copyWith(
            isLoading: false,
            listHistoryBooking: data,
            errorMsg: '',
          ));
        },
      ),
    );
  }
}
