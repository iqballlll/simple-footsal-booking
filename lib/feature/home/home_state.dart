part of 'home_cubit.dart';

class HomeState extends Equatable {
  const HomeState({
    this.isLoading = false,
    this.errorMsg = '',
    this.listSchedule = const [],
    this.countOrder = const <String, dynamic>{},
  });

  final bool isLoading;
  final String errorMsg;
  final List<ScheduleEntity> listSchedule;
  final Map<String, dynamic> countOrder;

  @override
  List<Object?> get props => [isLoading, errorMsg, listSchedule, countOrder];

  HomeState copyWith({
    bool? isLoading,
    String? errorMsg,
    Map<String, dynamic>? countOrder,
    List<ScheduleEntity>? listSchedule,
  }) {
    return HomeState(
      countOrder: countOrder ?? this.countOrder,
      isLoading: isLoading ?? this.isLoading,
      errorMsg: errorMsg ?? this.errorMsg,
      listSchedule: listSchedule ?? this.listSchedule,
    );
  }
}
