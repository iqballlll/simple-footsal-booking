import 'dart:convert';

import 'package:equatable/equatable.dart';

class Pivot extends Equatable {
  final int? productId;
  final int? orderId;

  const Pivot({this.productId, this.orderId});

  factory Pivot.fromMap(Map<String, dynamic> data) => Pivot(
        productId: data['product_id'] as int?,
        orderId: data['order_id'] as int?,
      );

  Map<String, dynamic> toMap() => {
        'product_id': productId,
        'order_id': orderId,
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [Pivot].
  factory Pivot.fromJson(String data) {
    return Pivot.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [Pivot] to a JSON string.
  String toJson() => json.encode(toMap());

  Pivot copyWith({
    int? productId,
    int? orderId,
  }) {
    return Pivot(
      productId: productId ?? this.productId,
      orderId: orderId ?? this.orderId,
    );
  }

  @override
  List<Object?> get props => [productId, orderId];
}
