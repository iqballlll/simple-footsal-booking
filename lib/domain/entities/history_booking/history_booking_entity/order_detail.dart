import 'dart:convert';

import 'package:equatable/equatable.dart';

import 'product.dart';

class OrderDetail extends Equatable {
  final int? id;
  final int? orderId;
  final int? productId;
  final Product? product;

  const OrderDetail({this.id, this.orderId, this.productId, this.product});

  factory OrderDetail.fromMap(Map<String, dynamic> data) => OrderDetail(
        id: data['id'] as int?,
        orderId: data['order_id'] as int?,
        productId: data['product_id'] as int?,
        product: data['product'] == null
            ? null
            : Product.fromMap(data['product'] as Map<String, dynamic>),
      );

  Map<String, dynamic> toMap() => {
        'id': id,
        'order_id': orderId,
        'product_id': productId,
        'product': product?.toMap(),
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [OrderDetail].
  factory OrderDetail.fromJson(String data) {
    return OrderDetail.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [OrderDetail] to a JSON string.
  String toJson() => json.encode(toMap());

  OrderDetail copyWith({
    int? id,
    int? orderId,
    int? productId,
    Product? product,
  }) {
    return OrderDetail(
      id: id ?? this.id,
      orderId: orderId ?? this.orderId,
      productId: productId ?? this.productId,
      product: product ?? this.product,
    );
  }

  @override
  List<Object?> get props => [id, orderId, productId, product];
}
