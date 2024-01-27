part of 'change_profile_cubit.dart';

class ChangeProfileState extends Equatable {
  const ChangeProfileState({
    this.isLoading = false,
    this.isSuccessUpdate = false,
    this.errorMsg = '',
    this.profile = const ChangeProfileEntity(),
  });

  final bool isLoading;
  final bool isSuccessUpdate;
  final String errorMsg;
  final ChangeProfileEntity profile;

  @override
  List<Object> get props => [isLoading, errorMsg, profile, isSuccessUpdate];

  ChangeProfileState copyWith({
    bool? isLoading,
    bool? isSuccessUpdate,
    String? errorMsg,
    ChangeProfileEntity? profile,
  }) {
    return ChangeProfileState(
      isLoading: isLoading ?? this.isLoading,
      isSuccessUpdate: isSuccessUpdate ?? this.isSuccessUpdate,
      errorMsg: errorMsg ?? this.errorMsg,
      profile: profile ?? this.profile,
    );
  }
}
