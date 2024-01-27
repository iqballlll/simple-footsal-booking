import 'package:either_dart/either.dart';
import 'package:mobile_customer/core/service/api_exception.dart';
import 'package:mobile_customer/domain/entities/default_response.dart';

class LeftEither<T> {
  Left<DefaultResponse, T> error(Either<ApiException, dynamic> data) {
    if (data.left.data != null) {
      final err = DefaultResponse.fromMap(data.left.data!);

      return Left(err);
    } else {
      final err = DefaultResponse(
          code: data.left.code,
          status: false,
          msg: data.left.message,
          data: const <String, dynamic>{});

      return Left(err);
    }
  }
}
