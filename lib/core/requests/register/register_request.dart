class RegisterRequest {
  const RegisterRequest({
    required this.name,
    required this.email,
    required this.phone,
    required this.address,
    required this.password,
    required this.confirmPassword,
  });

  final String name;
  final String email;
  final String phone;
  final String address;
  final String password;
  final String confirmPassword;

  Map<String, dynamic> toMap() {
    return {
      "name": name,
      "email": email,
      "phone": phone,
      "address": address,
      "password": password,
      "confirmation_password": confirmPassword,
    };
  }
}
