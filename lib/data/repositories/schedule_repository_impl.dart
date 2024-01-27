import 'package:either_dart/either.dart';
import 'package:mobile_customer/core/utilities/left_either.dart';
import 'package:mobile_customer/data/remote/remote_data_source.dart';
import 'package:mobile_customer/domain/entities/active_schedule/active_schedule_entity/active_schedule_entity.dart';
import 'package:mobile_customer/domain/entities/default_response.dart';
import 'package:mobile_customer/domain/repositories/schedule_repository.dart';

class ScheduleRepositoryImpl implements ScheduleRepository {
  final RemoteDataSource remoteDataSource = RemoteDataSource();
  @override
  Future<Either<DefaultResponse, List<ActiveScheduleEntity>>>
      getActiveSchedule() async {
    try {
      var data = await remoteDataSource.call(needAuth: true).then((api) {
        return api.get('/order');
      });
      if (data.isLeft) {
        return LeftEither<List<ActiveScheduleEntity>>().error(data);
      } else {
        var dc = data.right as Map<String, dynamic>;

        List<ActiveScheduleEntity> schedule = (dc['data'] as List<dynamic>)
            .map((item) => ActiveScheduleEntity.fromMap(item))
            .toList();

        return Right(schedule);
      }
    } catch (e) {
      rethrow;
    }
  }
}
