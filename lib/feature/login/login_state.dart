part of 'login_cubit.dart';

class LoginState extends Equatable {
  const LoginState({
    this.isLoading = false,
    this.errorMsg = "",
    this.data = const LoginEntity(),
  });

  final bool isLoading;
  final String errorMsg;
  final LoginEntity data;

  @override
  List<Object?> get props => [isLoading, errorMsg, data];

  LoginState copyWith({
    bool? isLoading,
    String? errorMsg,
    LoginEntity? data,
  }) {
    return LoginState(
      isLoading: isLoading ?? this.isLoading,
      errorMsg: errorMsg ?? this.errorMsg,
      data: data ?? this.data,
    );
  }
}
