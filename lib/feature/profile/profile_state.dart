part of 'profile_cubit.dart';

class ProfileState extends Equatable {
  const ProfileState({
    this.isLoading = false,
    this.errorMsg = '',
  });

  final bool isLoading;
  final String errorMsg;

  @override
  List<Object?> get props => [isLoading, errorMsg];

  ProfileState copyWith({
    bool? isLoading,
    String? errorMsg,
  }) {
    return ProfileState(
      isLoading: isLoading ?? this.isLoading,
      errorMsg: errorMsg ?? this.errorMsg,
    );
  }
}
