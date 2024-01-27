import 'dart:convert';

import 'package:equatable/equatable.dart';

class Product extends Equatable {
  final int? id;
  final String? name;
  final String? price;

  const Product({this.id, this.name, this.price});

  factory Product.fromMap(Map<String, dynamic> data) => Product(
        id: data['id'] as int?,
        name: data['name'] as String?,
        price: data['price'] as String?,
      );

  Map<String, dynamic> toMap() => {
        'id': id,
        'name': name,
        'price': price,
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [Product].
  factory Product.fromJson(String data) {
    return Product.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [Product] to a JSON string.
  String toJson() => json.encode(toMap());

  Product copyWith({
    int? id,
    String? name,
    String? price,
  }) {
    return Product(
      id: id ?? this.id,
      name: name ?? this.name,
      price: price ?? this.price,
    );
  }

  @override
  List<Object?> get props => [id, name, price];
}
