import 'package:either_dart/either.dart';
import 'package:mobile_customer/core/utilities/left_either.dart';
import 'package:mobile_customer/data/remote/remote_data_source.dart';
import 'package:mobile_customer/domain/entities/default_response.dart';
import 'package:mobile_customer/domain/entities/schedule_entity.dart/schedule_entity/schedule_entity.dart';
import 'package:mobile_customer/domain/repositories/home_repository.dart';

class HomeRepositoryImpl implements HomeRepository {
  final RemoteDataSource remoteDataSource = RemoteDataSource();
  @override
  Future<Either<DefaultResponse, List<ScheduleEntity>>> getSchedule() async {
    try {
      var data = await remoteDataSource.call(needAuth: true).then((api) {
        return api.get('/product');
      });
      if (data.isLeft) {
        return LeftEither<List<ScheduleEntity>>().error(data);
      } else {
        var dc = data.right as Map<String, dynamic>;

        List<ScheduleEntity> schedule = (dc['data'] as List<dynamic>)
            .map((item) => ScheduleEntity.fromMap(item))
            .toList();

        return Right(schedule);
      }
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<Either<DefaultResponse, Map<String, dynamic>>> getCountOrder() async {
    try {
      var data = await remoteDataSource.call(needAuth: true).then((api) {
        return api.get('/order/count', showLog: true);
      });
      if (data.isLeft) {
        return LeftEither<Map<String, dynamic>>().error(data);
      } else {
        var dc = data.right as Map<String, dynamic>;

        Map<String, dynamic> schedule = dc['data'];

        return Right(schedule);
      }
    } catch (e) {
      rethrow;
    }
  }
}
