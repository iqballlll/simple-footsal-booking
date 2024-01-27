part of 'add_booking_cubit.dart';

class AddBookingState extends Equatable {
  const AddBookingState({
    this.selectedSchedule = const [],
    this.isLoading = false,
    this.errorMsg = "",
    this.data = const AddBookingEntity(),
    this.listSchedule = const [],
  });
  final bool isLoading;
  final String errorMsg;
  final AddBookingEntity data;
  final List<ScheduleEntity> listSchedule;
  final List<int> selectedSchedule;

  @override
  List<Object?> get props =>
      [selectedSchedule, isLoading, errorMsg, data, listSchedule];

  AddBookingState copyWith({
    List<int>? selectedSchedule,
    bool? isLoading,
    String? errorMsg,
    AddBookingEntity? data,
    List<ScheduleEntity>? listSchedule,
  }) {
    return AddBookingState(
      selectedSchedule: selectedSchedule ?? this.selectedSchedule,
      isLoading: isLoading ?? this.isLoading,
      errorMsg: errorMsg ?? this.errorMsg,
      data: data ?? this.data,
      listSchedule: listSchedule ?? this.listSchedule,
    );
  }
}
