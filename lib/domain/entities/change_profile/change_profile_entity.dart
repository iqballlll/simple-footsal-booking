import 'dart:convert';

import 'package:equatable/equatable.dart';

class ChangeProfileEntity extends Equatable {
  final String? name;
  final String? email;
  final String? phone;
  final String? address;
  final int? id;

  const ChangeProfileEntity({
    this.name,
    this.email,
    this.phone,
    this.address,
    this.id,
  });

  factory ChangeProfileEntity.fromMap(Map<String, dynamic> data) {
    return ChangeProfileEntity(
      name: data['name'] as String?,
      email: data['email'] as String?,
      phone: data['phone'] as String?,
      address: data['address'] as String?,
      id: data['id'] as int?,
    );
  }

  Map<String, dynamic> toMap() => {
        'name': name,
        'email': email,
        'phone': phone,
        'address': address,
        'id': id,
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [ChangeProfileEntity].
  factory ChangeProfileEntity.fromJson(String data) {
    return ChangeProfileEntity.fromMap(
        json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [ChangeProfileEntity] to a JSON string.
  String toJson() => json.encode(toMap());

  ChangeProfileEntity copyWith({
    String? name,
    String? email,
    String? phone,
    String? address,
    int? id,
  }) {
    return ChangeProfileEntity(
      name: name ?? this.name,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      address: address ?? this.address,
      id: id ?? this.id,
    );
  }

  @override
  List<Object?> get props => [name, email, phone, address, id];
}
