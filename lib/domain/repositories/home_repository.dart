import 'package:either_dart/either.dart';
import 'package:mobile_customer/domain/entities/default_response.dart';
import 'package:mobile_customer/domain/entities/schedule_entity.dart/schedule_entity/schedule_entity.dart';

abstract class HomeRepository {
  Future<Either<DefaultResponse, List<ScheduleEntity>>> getSchedule();
  Future<Either<DefaultResponse, Map<String, dynamic>>> getCountOrder();
}
