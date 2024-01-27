class ChangePasswordRequest {
  const ChangePasswordRequest({
    this.oldPassword = '',
    this.newPassword = '',
    this.confirmPassword = '',
  });
  final String oldPassword;
  final String newPassword;
  final String confirmPassword;

  Map<String, dynamic> toMap() {
    return {
      'old_password': oldPassword,
      'new_password': newPassword,
    };
  }
}
