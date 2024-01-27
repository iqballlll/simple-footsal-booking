part of 'register_cubit.dart';

class RegisterState extends Equatable {
  const RegisterState({
    this.isLoading = false,
    this.errorMsg = "",
    this.data = const RegisterEntity(),
  });

  final bool isLoading;
  final String errorMsg;
  final RegisterEntity data;
  @override
  List<Object> get props => [isLoading, errorMsg, data];

  RegisterState copyWith({
    bool? isLoading,
    String? errorMsg,
    RegisterEntity? data,
  }) {
    return RegisterState(
      isLoading: isLoading ?? this.isLoading,
      errorMsg: errorMsg ?? this.errorMsg,
      data: data ?? this.data,
    );
  }
}
