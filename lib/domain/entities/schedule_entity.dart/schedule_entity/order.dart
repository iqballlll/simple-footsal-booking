import 'dart:convert';

import 'package:equatable/equatable.dart';

import 'pivot.dart';

class Order extends Equatable {
  final int? id;
  final String? orderDate;
  final String? downPayment;
  final String? name;
  final String? phone;
  final String? email;
  final Pivot? pivot;

  const Order({
    this.id,
    this.orderDate,
    this.downPayment,
    this.name,
    this.phone,
    this.email,
    this.pivot,
  });

  factory Order.fromMap(Map<String, dynamic> data) => Order(
        id: data['id'] as int?,
        orderDate: data['order_date'] as String?,
        downPayment: data['down_payment'] as String?,
        name: data['name'] as String?,
        phone: data['phone'] as String?,
        email: data['email'] as String?,
        pivot: data['pivot'] == null
            ? null
            : Pivot.fromMap(data['pivot'] as Map<String, dynamic>),
      );

  Map<String, dynamic> toMap() => {
        'id': id,
        'order_date': orderDate,
        'down_payment': downPayment,
        'name': name,
        'phone': phone,
        'email': email,
        'pivot': pivot?.toMap(),
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [Order].
  factory Order.fromJson(String data) {
    return Order.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [Order] to a JSON string.
  String toJson() => json.encode(toMap());

  Order copyWith({
    int? id,
    String? orderDate,
    String? downPayment,
    String? name,
    String? phone,
    String? email,
    Pivot? pivot,
  }) {
    return Order(
      id: id ?? this.id,
      orderDate: orderDate ?? this.orderDate,
      downPayment: downPayment ?? this.downPayment,
      name: name ?? this.name,
      phone: phone ?? this.phone,
      email: email ?? this.email,
      pivot: pivot ?? this.pivot,
    );
  }

  @override
  List<Object?> get props {
    return [
      id,
      orderDate,
      downPayment,
      name,
      phone,
      email,
      pivot,
    ];
  }
}
