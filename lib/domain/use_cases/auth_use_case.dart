import 'package:either_dart/either.dart';
import 'package:mobile_customer/domain/entities/default_response.dart';
import 'package:mobile_customer/domain/entities/login/login_entity.dart';
import 'package:mobile_customer/domain/entities/profile/profile_entity.dart';
import 'package:mobile_customer/domain/entities/register/register_entity.dart';
import 'package:mobile_customer/domain/repositories/auth_repository.dart';

class AuthUseCase {
  AuthUseCase(this.repository);

  final AuthRepository repository;

  Future<Either<DefaultResponse, LoginEntity>> login(
      Map<String, dynamic> payload) async {
    return await repository.login(payload);
  }

  Future<Either<DefaultResponse, RegisterEntity>> register(
      Map<String, dynamic> payload) async {
    return await repository.register(payload);
  }

  Future<Either<DefaultResponse, DefaultResponse>> logout() async {
    return await repository.logout();
  }

  Future<Either<DefaultResponse, ProfileEntity>> getProfile() async {
    return await repository.getProfile();
  }

  Future<Either<DefaultResponse, ProfileEntity>> updateProfile(
      Map<String, dynamic> payload) async {
    return await repository.updateProfile(payload);
  }

  Future<Either<DefaultResponse, Map<String, dynamic>>> updatePassword(
      Map<String, dynamic> payload) async {
    return await repository.updatePassword(payload);
  }
}
