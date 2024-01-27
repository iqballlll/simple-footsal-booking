import 'dart:convert';

import 'package:equatable/equatable.dart';

import 'order_detail.dart';

class HistoryBookingEntity extends Equatable {
  final int? id;
  final String? orderNumber;
  final String? status;
  final String? orderDate;
  final int? customerId;
  final String? downPayment;
  final List<OrderDetail>? orderDetail;

  const HistoryBookingEntity({
    this.id,
    this.orderNumber,
    this.status,
    this.orderDate,
    this.customerId,
    this.downPayment,
    this.orderDetail,
  });

  factory HistoryBookingEntity.fromMap(Map<String, dynamic> data) {
    return HistoryBookingEntity(
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
  /// Parses the string and returns the resulting Json object as [HistoryBookingEntity].
  factory HistoryBookingEntity.fromJson(String data) {
    return HistoryBookingEntity.fromMap(
        json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [HistoryBookingEntity] to a JSON string.
  String toJson() => json.encode(toMap());

  HistoryBookingEntity copyWith({
    int? id,
    String? orderNumber,
    String? status,
    String? orderDate,
    int? customerId,
    String? downPayment,
    List<OrderDetail>? orderDetail,
  }) {
    return HistoryBookingEntity(
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
