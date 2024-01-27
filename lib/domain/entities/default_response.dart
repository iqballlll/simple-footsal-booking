import 'dart:convert';

import 'package:equatable/equatable.dart';

class DefaultResponse extends Equatable {
  final int? code;
  final bool? status;
  final Map<String, dynamic>? data;
  final String? msg;

  const DefaultResponse({this.code, this.status, this.data, this.msg});

  factory DefaultResponse.fromMap(Map<String, dynamic> data) {
    return DefaultResponse(
      code: data['code'] as int?,
      status: data['status'] as bool?,
      data: data['data'] as Map<String, dynamic>,
      msg: data['msg'] as String?,
    );
  }

  Map<String, dynamic> toMap() => {
        'code': code,
        'status': status,
        'data': data,
        'msg': msg,
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [DefaultResponse].
  factory DefaultResponse.fromJson(String data) {
    return DefaultResponse.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [DefaultResponse] to a JSON string.
  String toJson() => json.encode(toMap());

  DefaultResponse copyWith({
    int? code,
    bool? status,
    Map<String, dynamic>? data,
    String? msg,
  }) {
    return DefaultResponse(
      code: code ?? this.code,
      status: status ?? this.status,
      data: data ?? this.data,
      msg: msg ?? this.msg,
    );
  }

  @override
  List<Object?> get props => [code, status, data, msg];
}
