part of 'history_cubit.dart';

class HistoryState extends Equatable {
  @override
  const HistoryState({
    this.isLoading = false,
    this.errorMsg = '',
    this.listHistoryBooking = const [],
  });
  final bool isLoading;
  final String errorMsg;
  final List<HistoryBookingEntity> listHistoryBooking;

  @override
  List<Object?> get props => [isLoading, errorMsg, listHistoryBooking];

  HistoryState copyWith({
    bool? isLoading,
    String? errorMsg,
    List<HistoryBookingEntity>? listHistoryBooking,
  }) {
    return HistoryState(
      isLoading: isLoading ?? this.isLoading,
      errorMsg: errorMsg ?? this.errorMsg,
      listHistoryBooking: listHistoryBooking ?? this.listHistoryBooking,
    );
  }
}
