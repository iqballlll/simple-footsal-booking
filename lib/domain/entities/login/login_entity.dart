import 'dart:convert';

import 'package:equatable/equatable.dart';

class LoginEntity extends Equatable {
  final String? token;

  const LoginEntity({this.token});

  factory LoginEntity.fromMap(Map<String, dynamic> data) => LoginEntity(
        token: data['token'] as String?,
      );

  Map<String, dynamic> toMap() => {
        'token': token,
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [LoginEntity].
  factory LoginEntity.fromJson(String data) {
    return LoginEntity.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [LoginEntity] to a JSON string.
  String toJson() => json.encode(toMap());

  LoginEntity copyWith({
    String? token,
  }) {
    return LoginEntity(
      token: token ?? this.token,
    );
  }

  @override
  List<Object?> get props => [token];
}
