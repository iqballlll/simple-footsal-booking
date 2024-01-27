import 'package:either_dart/either.dart';
import 'package:mobile_customer/domain/entities/active_schedule/active_schedule_entity/active_schedule_entity.dart';
import 'package:mobile_customer/domain/entities/default_response.dart';
import 'package:mobile_customer/domain/repositories/schedule_repository.dart';

class ScheduleUseCase {
  ScheduleUseCase(this.repository);

  final ScheduleRepository repository;

  Future<Either<DefaultResponse, List<ActiveScheduleEntity>>> getActiveSchedule(
      Map<String, dynamic> payload) async {
    return await repository.getActiveSchedule();
  }
}
