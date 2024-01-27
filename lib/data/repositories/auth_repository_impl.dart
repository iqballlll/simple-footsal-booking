import 'package:either_dart/either.dart';
import 'package:mobile_customer/core/utilities/left_either.dart';
import 'package:mobile_customer/data/remote/remote_data_source.dart';
import 'package:mobile_customer/domain/entities/default_response.dart';
import 'package:mobile_customer/domain/entities/login/login_entity.dart';
import 'package:mobile_customer/domain/entities/profile/profile_entity.dart';
import 'package:mobile_customer/domain/entities/register/register_entity.dart';
import 'package:mobile_customer/domain/repositories/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final RemoteDataSource remoteDataSource = RemoteDataSource();

  @override
  Future<Either<DefaultResponse, LoginEntity>> login(
      Map<String, dynamic> payload) async {
    try {
      var data = await remoteDataSource.call().then((api) {
        return api.post<Map<String, dynamic>>("/login", data: payload);
      });

      if (data.isLeft) {
        return LeftEither<LoginEntity>().error(data);
      } else {
        var dc = data.right as Map<String, dynamic>;

        LoginEntity login = LoginEntity.fromMap(dc['data']);
        return Right(login);
      }
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<Either<DefaultResponse, RegisterEntity>> register(
      Map<String, dynamic> payload) async {
    try {
      var data = await remoteDataSource.call().then((api) {
        return api.post<Map<String, dynamic>>(
          "/register",
          data: payload,
          showLog: true,
        );
      });

      if (data.isLeft) {
        return LeftEither<RegisterEntity>().error(data);
      } else {
        RegisterEntity register = RegisterEntity.fromMap(data.right);
        return Right(register);
      }
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<Either<DefaultResponse, DefaultResponse>> logout() async {
    try {
      var data = await remoteDataSource.call(needAuth: true).then((api) {
        return api
            .post<Map<String, dynamic>>("/logout", data: <String, dynamic>{});
      });

      if (data.isLeft) {
        return LeftEither<DefaultResponse>().error(data);
      } else {
        DefaultResponse logout = DefaultResponse.fromMap(data.right);
        return Right(logout);
      }
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<Either<DefaultResponse, ProfileEntity>> getProfile() async {
    try {
      var data = await remoteDataSource.call(needAuth: true).then((api) {
        return api.get("/profile");
      });

      if (data.isLeft) {
        return LeftEither<ProfileEntity>().error(data);
      } else {
        var dc = data.right as Map<String, dynamic>;
        ProfileEntity logout = ProfileEntity.fromMap(dc['data']);
        return Right(logout);
      }
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<Either<DefaultResponse, ProfileEntity>> updateProfile(
      Map<String, dynamic> payload) async {
    try {
      var data = await remoteDataSource.call(needAuth: true).then((api) {
        return api.put<Map<String, dynamic>>(
          "/profile",
          data: payload,
          showLog: true,
        );
      });

      if (data.isLeft) {
        return LeftEither<ProfileEntity>().error(data);
      } else {
        var dc = data.right as Map<String, dynamic>;
        ProfileEntity profile = ProfileEntity.fromMap(dc['data']);
        return Right(profile);
      }
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<Either<DefaultResponse, Map<String, dynamic>>> updatePassword(
      Map<String, dynamic> payload) async {
    try {
      var data = await remoteDataSource.call(needAuth: true).then((api) {
        return api.put<Map<String, dynamic>>(
          "/profile/password",
          data: payload,
          showLog: true,
        );
      });

      if (data.isLeft) {
        return LeftEither<Map<String, dynamic>>().error(data);
      } else {
        return const Right(<String, dynamic>{});
      }
    } catch (e) {
      rethrow;
    }
  }
}
