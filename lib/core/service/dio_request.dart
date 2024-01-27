import 'package:dio/dio.dart';
import 'package:dio_http_formatter/dio_http_formatter.dart';
import 'package:dio_smart_retry/dio_smart_retry.dart';
import 'package:either_dart/either.dart';
import 'package:mobile_customer/core/service/api_exception.dart';
import 'package:mobile_customer/core/service/http_method.dart';
import 'dart:developer';

import 'package:mobile_customer/core/utilities/constants/message_constant.dart';
import 'package:mobile_customer/env/env.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

class DioRequest with HttpMethod {
  Duration connectTimeout = const Duration(seconds: 5);
  Duration receiveTimeout = const Duration(seconds: 10);
  Duration sendTimeout = const Duration(seconds: 3);
  DioRequest({
    required this.baseUrl,
    required this.acceptHeaders,
    required this.headers,
  }) {
    dio = Dio(BaseOptions(
      connectTimeout: connectTimeout,
      receiveTimeout: receiveTimeout,
      sendTimeout: sendTimeout,
      headers: headers,
      baseUrl: "http://103.152.119.203:9090/api/v1/customer",
      receiveDataWhenStatusError: true,
      contentType: Headers.jsonContentType,
    ));
  }

  final String baseUrl;
  final Map<String, dynamic> acceptHeaders;
  final dynamic headers;
  late final Dio dio;

  @override
  Future<Either<ApiException, dynamic>> delete<T>(
    String url, {
    Map<String, dynamic>? param,
    showLog = false,
    retries = 3,
  }) async {
    final Options options = Options(headers: headers);

    if (showLog) dio.interceptors.add(PrettyDioLogger());

    dio.interceptors
        .add(RetryInterceptor(dio: dio, retries: retries, logPrint: log));

    return await callDio(
        dio.delete(url, options: options, queryParameters: param));
  }

  @override
  Future<Either<ApiException, dynamic>> get(String url,
      {Map<String, dynamic>? param, showLog = false, retries = 3}) async {
    final Options options = Options(headers: headers);

    if (showLog) dio.interceptors.add(HttpFormatter());

    dio.interceptors
        .add(RetryInterceptor(dio: dio, retries: retries, logPrint: log));

    return await callDio(
        dio.get(url, options: options, queryParameters: param));
  }

  @override
  Future<Either<ApiException, dynamic>> post<T>(String url,
      {T? data, showLog = false, retries = 3}) async {
    final Options options = Options(headers: headers);

    if (showLog) dio.interceptors.add(HttpFormatter());

    dio.interceptors
        .add(RetryInterceptor(dio: dio, retries: retries, logPrint: log));

    return await callDio(dio.post(url, options: options, data: data));
  }

  @override
  Future<Either<ApiException, dynamic>> put<T>(String url,
      {T? data, showLog = false, retries = 3}) async {
    final Options options = Options(headers: headers);

    if (showLog) dio.interceptors.add(HttpFormatter());

    dio.interceptors
        .add(RetryInterceptor(dio: dio, retries: retries, logPrint: log));

    return await callDio(dio.put(url, options: options, data: data));
  }

  Future<Either<ApiException, dynamic>> callDio(
      Future<Response> dioRequest) async {
    try {
      var res = await dioRequest;

      return Right(res.data);
    } on DioException catch (e) {
      if (e.type == DioExceptionType.connectionTimeout) {
        return Left(
          ApiException(
            code: e.response?.statusCode,
            message: MessageConstant.connectionTimeout,
          ),
        );
      }
      if (e.type == DioExceptionType.sendTimeout) {
        return Left(
          ApiException(
            code: e.response?.statusCode,
            message: MessageConstant.sendTimeout,
          ),
        );
      }
      if (e.type == DioExceptionType.receiveTimeout) {
        return Left(
          ApiException(
            code: e.response?.statusCode,
            message: MessageConstant.receiveTimeout,
          ),
        );
      }
      if (e.type == DioExceptionType.badResponse) {
        var responseData = e.response?.data;
        if (responseData != null && responseData is Map<String, dynamic>) {
          var msg = responseData['msg'];

          return Left(
            ApiException(
              code: e.response?.statusCode,
              message: msg ?? MessageConstant.badResponse,
            ),
          );
        }
      }
      if (e.type == DioExceptionType.unknown) {
        return Left(
          ApiException(
            code: e.response?.statusCode,
            message: MessageConstant.unknown,
          ),
        );
      }
      return Left(ApiException(
        code: e.response?.statusCode,
        message: e.message,
        data: e.response?.data,
      ));
    } on FormatException {
      return const Left(ApiException(
        message: "Terjadi error, silakan coba lagi",
      ));
    }
  }
}
