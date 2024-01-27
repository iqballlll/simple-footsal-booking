class LoginRequest {
  const LoginRequest({
    required this.email,
    required this.password,
  });

  final String email;

  final String password;

  Map<String, dynamic> toMap() {
    return {
      "email": email,
      "password": password,
    };
  }
}
