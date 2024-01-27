import 'package:either_dart/either.dart';
import 'package:mobile_customer/domain/entities/default_response.dart';
import 'package:mobile_customer/domain/entities/login/login_entity.dart';
import 'package:mobile_customer/domain/entities/profile/profile_entity.dart';
import 'package:mobile_customer/domain/entities/register/register_entity.dart';

abstract class AuthRepository {
  Future<Either<DefaultResponse, LoginEntity>> login(Map<String, dynamic> data);

  Future<Either<DefaultResponse, RegisterEntity>> register(
      Map<String, dynamic> data);

  Future<Either<DefaultResponse, DefaultResponse>> logout();

  Future<Either<DefaultResponse, ProfileEntity>> getProfile();
  Future<Either<DefaultResponse, ProfileEntity>> updateProfile(
      Map<String, dynamic> data);
  Future<Either<DefaultResponse, Map<String, dynamic>>> updatePassword(
      Map<String, dynamic> data);
}
