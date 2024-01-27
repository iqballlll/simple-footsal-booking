import 'dart:convert';

import 'package:equatable/equatable.dart';

import 'order.dart';

class ScheduleEntity extends Equatable {
  final int? id;
  final String? name;
  final String? description;
  final int? time;
  final int? price;
  final List<Order>? orders;

  const ScheduleEntity({
    this.id,
    this.name,
    this.description,
    this.time,
    this.price,
    this.orders,
  });

  factory ScheduleEntity.fromMap(Map<String, dynamic> data) {
    return ScheduleEntity(
      id: data['id'] as int?,
      name: data['name'] as String?,
      description: data['description'] as String?,
      time: data['time'] as int?,
      price: data['price'] as int?,
      orders: (data['orders'] as List<dynamic>?)
          ?.map((e) => Order.fromMap(e as Map<String, dynamic>))
          .toList(),
    );
  }

  Map<String, dynamic> toMap() => {
        'id': id,
        'name': name,
        'description': description,
        'time': time,
        'price': price,
        'orders': orders?.map((e) => e.toMap()).toList(),
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [ScheduleEntity].
  factory ScheduleEntity.fromJson(String data) {
    return ScheduleEntity.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [ScheduleEntity] to a JSON string.
  String toJson() => json.encode(toMap());

  ScheduleEntity copyWith({
    int? id,
    String? name,
    String? description,
    int? time,
    int? price,
    List<Order>? orders,
  }) {
    return ScheduleEntity(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      time: time ?? this.time,
      price: price ?? this.price,
      orders: orders ?? this.orders,
    );
  }

  @override
  List<Object?> get props => [id, name, description, time, price, orders];
}
