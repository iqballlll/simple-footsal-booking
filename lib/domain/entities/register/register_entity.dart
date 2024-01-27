import 'dart:convert';

import 'package:equatable/equatable.dart';

class RegisterEntity extends Equatable {
  final int? id;
  final String? name;
  final String? email;
  final String? phone;
  final String? address;
  final DateTime? createdAt;

  const RegisterEntity({
    this.id,
    this.name,
    this.email,
    this.phone,
    this.address,
    this.createdAt,
  });

  factory RegisterEntity.fromMap(Map<String, dynamic> data) => RegisterEntity(
        id: data['id'] as int?,
        name: data['name'] as String?,
        email: data['email'] as String?,
        phone: data['phone'] as String?,
        address: data['address'] as String?,
        createdAt: data['created_at'] == null
            ? null
            : DateTime.parse(data['created_at'] as String),
      );

  Map<String, dynamic> toMap() => {
        'id': id,
        'name': name,
        'email': email,
        'phone': phone,
        'address': address,
        'created_at': createdAt?.toIso8601String(),
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [Data].
  factory RegisterEntity.fromJson(String data) {
    return RegisterEntity.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [Data] to a JSON string.
  String toJson() => json.encode(toMap());

  RegisterEntity copyWith({
    int? id,
    String? name,
    String? email,
    String? phone,
    String? address,
    DateTime? createdAt,
  }) {
    return RegisterEntity(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      address: address ?? this.address,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  List<Object?> get props => [id, name, email, phone, address, createdAt];
}
