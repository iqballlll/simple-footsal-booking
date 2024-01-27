import 'package:either_dart/either.dart';
import 'package:mobile_customer/core/utilities/left_either.dart';
import 'package:mobile_customer/data/remote/remote_data_source.dart';
import 'package:mobile_customer/domain/entities/add_booking/add_booking_entity.dart';
import 'package:mobile_customer/domain/entities/default_response.dart';
import 'package:mobile_customer/domain/entities/history_booking/history_booking_entity/history_booking_entity.dart';
import 'package:mobile_customer/domain/entities/schedule_entity.dart/schedule_entity/schedule_entity.dart';
import 'package:mobile_customer/domain/repositories/booking_repository.dart';

class BookingRepositoryImpl implements BookingRepository {
  final RemoteDataSource remoteDataSource = RemoteDataSource();
  @override
  Future<Either<DefaultResponse, AddBookingEntity>> addBooking(
      Map<String, dynamic> payload) async {
    try {
      var data = await remoteDataSource.call(needAuth: true).then((api) {
        return api.post<Map<String, dynamic>>("/order",
            data: payload, showLog: true);
      });

      if (data.isLeft) {
        return LeftEither<AddBookingEntity>().error(data);
      } else {
        var dc = data.right as Map<String, dynamic>;

        AddBookingEntity addBooking = AddBookingEntity.fromMap(dc['data']);
        return Right(addBooking);
      }
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<Either<DefaultResponse, List<HistoryBookingEntity>>> historyBooking(
      Map<String, dynamic> payload) async {
    try {
      var data = await remoteDataSource.call(needAuth: true).then((api) {
        return api.get("/order/history", param: payload, showLog: true);
      });

      if (data.isLeft) {
        return LeftEither<List<HistoryBookingEntity>>().error(data);
      } else {
        var dc = data.right as Map<String, dynamic>;

        List<HistoryBookingEntity> schedule = (dc['data'] as List<dynamic>)
            .map((item) => HistoryBookingEntity.fromMap(item))
            .toList();
        return Right(schedule);
      }
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<Either<DefaultResponse, List<ScheduleEntity>>> refetchSchedule(
      Map<String, dynamic> payload) async {
    try {
      var data = await remoteDataSource.call(needAuth: true).then((api) {
        return api.get("/product", param: payload);
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
}
