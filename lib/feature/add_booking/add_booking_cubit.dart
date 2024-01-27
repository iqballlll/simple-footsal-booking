import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:mobile_customer/core/routes/app_router.dart';
import 'package:mobile_customer/data/repositories/booking_repository_impl.dart';
import 'package:mobile_customer/domain/entities/add_booking/add_booking_entity.dart';
import 'package:mobile_customer/domain/entities/schedule_entity.dart/schedule_entity/schedule_entity.dart';
import 'package:mobile_customer/domain/use_cases/booking_use_case.dart';
import 'package:mobile_customer/main.dart';

part 'add_booking_state.dart';

class AddBookingCubit extends Cubit<AddBookingState> {
  AddBookingCubit() : super(const AddBookingState());

  final BookingRepositoryImpl repository = BookingRepositoryImpl();

  void selectSchedule(int id) {
    List<int> currentSelectedSchedule = List<int>.from(state.selectedSchedule);

    currentSelectedSchedule.contains(id)
        ? currentSelectedSchedule.remove(id)
        : currentSelectedSchedule.add(id);

    emit(state.copyWith(selectedSchedule: currentSelectedSchedule));
  }

  FutureOr<void> addBooking(Map<String, dynamic> payload) async {
    BookingUseCase bookingUseCase = BookingUseCase(repository);

    bookingUseCase.addBooking(payload).then((res) {
      res.fold(
          (err) => emit(state.copyWith(
                errorMsg: err.msg.toString(),
                isLoading: false,
              )), (data) {
        emit(state.copyWith(isLoading: false, errorMsg: ''));
        MyApp.router.replace(const ScheduleRoute());
      });
    });
  }

  FutureOr<void> refetchSchedule(Map<String, dynamic> payload) async {
    BookingUseCase bookingUseCase = BookingUseCase(repository);

    emit(state.copyWith(isLoading: true));

    await bookingUseCase.refetchSchedule(payload).then((res) {
      res.fold(
          (err) => emit(state.copyWith(
                errorMsg: err.msg.toString(),
                isLoading: false,
              )), (data) {
        emit(
          state.copyWith(isLoading: false, errorMsg: '', listSchedule: data),
        );
      });
    });
  }
}
