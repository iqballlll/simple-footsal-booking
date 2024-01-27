part of 'change_password_cubit.dart';

class ChangePasswordState extends Equatable {
  const ChangePasswordState({
    this.isLoading = false,
    this.isSuccessUpdate = false,
    this.errorMsg = '',
  });
  final bool isLoading;
  final bool isSuccessUpdate;
  final String errorMsg;

  @override
  List<Object> get props => [isLoading, isSuccessUpdate, errorMsg];

  ChangePasswordState copyWith({
    final bool? isLoading,
    final bool? isSuccessUpdate,
    final String? errorMsg,
  }) {
    return ChangePasswordState(
      isLoading: isLoading ?? this.isLoading,
      isSuccessUpdate: isSuccessUpdate ?? this.isSuccessUpdate,
      errorMsg: errorMsg ?? this.errorMsg,
    );
  }
}
