import 'dart:convert';

import 'package:equatable/equatable.dart';

class ProfileEntity extends Equatable {
  final int? id;
  final String? name;
  final String? email;
  final String? phone;
  final String? address;
  final dynamic orderCount;

  const ProfileEntity({
    this.id,
    this.name,
    this.email,
    this.phone,
    this.address,
    this.orderCount,
  });

  factory ProfileEntity.fromMap(Map<String, dynamic> data) => ProfileEntity(
        id: data['id'] as int?,
        name: data['name'] as String?,
        email: data['email'] as String?,
        phone: data['phone'] as String?,
        address: data['address'] as String?,
        orderCount: data['order_count'] as dynamic,
      );

  Map<String, dynamic> toMap() => {
        'id': id,
        'name': name,
        'email': email,
        'phone': phone,
        'address': address,
        'order_count': orderCount,
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [ProfileEntity].
  factory ProfileEntity.fromJson(String data) {
    return ProfileEntity.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [ProfileEntity] to a JSON string.
  String toJson() => json.encode(toMap());

  ProfileEntity copyWith({
    int? id,
    String? name,
    String? email,
    String? phone,
    String? address,
    dynamic orderCount,
  }) {
    return ProfileEntity(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      address: address ?? this.address,
      orderCount: orderCount ?? this.orderCount,
    );
  }

  @override
  List<Object?> get props {
    return [
      id,
      name,
      email,
      phone,
      address,
      orderCount,
    ];
  }
}
