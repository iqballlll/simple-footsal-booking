part of 'schedule_cubit.dart';

class ScheduleState extends Equatable {
  const ScheduleState(
      {this.isLoading = false,
      this.errorMsg = '',
      this.listActiveSchedule = const []});

  final bool isLoading;
  final String errorMsg;
  final List<ActiveScheduleEntity> listActiveSchedule;

  @override
  List<Object?> get props => [isLoading, errorMsg, listActiveSchedule];

  ScheduleState copyWith({
    bool? isLoading,
    String? errorMsg,
    List<ActiveScheduleEntity>? listActiveSchedule,
  }) {
    return ScheduleState(
      isLoading: isLoading ?? this.isLoading,
      errorMsg: errorMsg ?? this.errorMsg,
      listActiveSchedule: listActiveSchedule ?? this.listActiveSchedule,
    );
  }
}
