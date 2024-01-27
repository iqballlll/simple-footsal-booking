class ChangeProfileRequest {
  const ChangeProfileRequest({
    this.name = '',
    this.email = '',
    this.phone = '',
    this.address = '',
  });
  final String name;
  final String email;
  final String phone;
  final String address;

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'email': email,
      'phone': phone,
      'address': address,
    };
  }
}
