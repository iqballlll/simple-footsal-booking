import 'package:either_dart/either.dart';
import 'package:mobile_customer/domain/entities/active_schedule/active_schedule_entity/active_schedule_entity.dart';
import 'package:mobile_customer/domain/entities/default_response.dart';

abstract class ScheduleRepository {
  Future<Either<DefaultResponse, List<ActiveScheduleEntity>>>
      getActiveSchedule();
}
