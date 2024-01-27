import 'dart:convert';

import 'package:equatable/equatable.dart';

class AddBookingEntity extends Equatable {
  final int? orderId;
  final String? orderNumber;
  final String? status;
  final String? orderDate;
  final int? customerId;
  final int? downPayment;
  final List<dynamic>? productId;
  final bool? isDiscount;
  final dynamic discount;

  const AddBookingEntity({
    this.orderId,
    this.orderNumber,
    this.status,
    this.orderDate,
    this.customerId,
    this.downPayment,
    this.productId,
    this.isDiscount,
    this.discount,
  });

  factory AddBookingEntity.fromMap(Map<String, dynamic> data) {
    return AddBookingEntity(
      orderId: data['order_id'] as int?,
      orderNumber: data['order_number'] as String?,
      status: data['status'] as String?,
      orderDate: data['order_date'] as String?,
      customerId: data['customer_id'] as int?,
      downPayment: data['down_payment'] as int?,
      productId: data['product_id'] as List<dynamic>?,
      isDiscount: data['is_discount'] as bool?,
      discount: data['discount'] as dynamic,
    );
  }

  Map<String, dynamic> toMap() => {
        'order_id': orderId,
        'order_number': orderNumber,
        'status': status,
        'order_date': orderDate,
        'customer_id': customerId,
        'down_payment': downPayment,
        'product_id': productId,
        'is_discount': isDiscount,
        'discount': discount,
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [AddBookingEntity].
  factory AddBookingEntity.fromJson(String data) {
    return AddBookingEntity.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [AddBookingEntity] to a JSON string.
  String toJson() => json.encode(toMap());

  AddBookingEntity copyWith({
    int? orderId,
    String? orderNumber,
    String? status,
    String? orderDate,
    int? customerId,
    int? downPayment,
    List<dynamic>? productId,
    bool? isDiscount,
    dynamic discount,
  }) {
    return AddBookingEntity(
      orderId: orderId ?? this.orderId,
      orderNumber: orderNumber ?? this.orderNumber,
      status: status ?? this.status,
      orderDate: orderDate ?? this.orderDate,
      customerId: customerId ?? this.customerId,
      downPayment: downPayment ?? this.downPayment,
      productId: productId ?? this.productId,
      isDiscount: isDiscount ?? this.isDiscount,
      discount: discount ?? this.discount,
    );
  }

  @override
  List<Object?> get props {
    return [
      orderId,
      orderNumber,
      status,
      orderDate,
      customerId,
      downPayment,
      productId,
      isDiscount,
      discount,
    ];
  }
}
