import 'dart:convert';

import 'package:equatable/equatable.dart';

import 'order_detail.dart';

class ActiveScheduleEntity extends Equatable {
  final int? id;
  final String? orderNumber;
  final String? status;
  final String? orderDate;
  final int? customerId;
  final String? downPayment;
  final List<OrderDetail>? orderDetail;

  const ActiveScheduleEntity({
    this.id,
    this.orderNumber,
    this.status,
    this.orderDate,
    this.customerId,
    this.downPayment,
    this.orderDetail,
  });

  factory ActiveScheduleEntity.fromMap(Map<String, dynamic> data) {
    return ActiveScheduleEntity(
      id: data['id'] as int?,
      orderNumber: data['order_number'] as String?,
      status: data['status'] as String?,
      orderDate: data['order_date'] as String?,
      customerId: data['customer_id'] as int?,
      downPayment: data['down_payment'] as String?,
      orderDetail: (data['order_detail'] as List<dynamic>?)
          ?.map((e) => OrderDetail.fromMap(e as Map<String, dynamic>))
          .toList(),
    );
  }

  Map<String, dynamic> toMap() => {
        'id': id,
        'order_number': orderNumber,
        'status': status,
        'order_date': orderDate,
        'customer_id': customerId,
        'down_payment': downPayment,
        'order_detail': orderDetail?.map((e) => e.toMap()).toList(),
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [ActiveScheduleEntity].
  factory ActiveScheduleEntity.fromJson(String data) {
    return ActiveScheduleEntity.fromMap(
        json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [ActiveScheduleEntity] to a JSON string.
  String toJson() => json.encode(toMap());

  ActiveScheduleEntity copyWith({
    int? id,
    String? orderNumber,
    String? status,
    String? orderDate,
    int? customerId,
    String? downPayment,
    List<OrderDetail>? orderDetail,
  }) {
    return ActiveScheduleEntity(
      id: id ?? this.id,
      orderNumber: orderNumber ?? this.orderNumber,
      status: status ?? this.status,
      orderDate: orderDate ?? this.orderDate,
      customerId: customerId ?? this.customerId,
      downPayment: downPayment ?? this.downPayment,
      orderDetail: orderDetail ?? this.orderDetail,
    );
  }

  @override
  List<Object?> get props {
    return [
      id,
      orderNumber,
      status,
      orderDate,
      customerId,
      downPayment,
      orderDetail,
    ];
  }
}
