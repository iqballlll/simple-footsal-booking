import 'dart:io';

import 'package:mobile_customer/core/service/dio_request.dart';
import 'package:mobile_customer/data/local/local_data_source.dart';
import 'package:mobile_customer/env/env.dart';

class RemoteDataSource {
  Future<Map<String, dynamic>> headers() async {
    final token = await LocalDataSource.get(key: "token");
    final headers = {HttpHeaders.authorizationHeader: "Bearer $token"};

    return headers;
  }

  Future<DioRequest> call({bool needAuth = false}) async {
    return DioRequest(
      baseUrl: "http://127.0.0.1:8000/api/v1/customer",
      acceptHeaders: {
        HttpHeaders.acceptHeader: "accept: application/json",
        HttpHeaders.contentTypeHeader: "application/json"
      },
      headers: needAuth ? await headers() : <String, dynamic>{},
    );
  }
}
