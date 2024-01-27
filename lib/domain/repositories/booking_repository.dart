import 'package:either_dart/either.dart';
import 'package:mobile_customer/domain/entities/add_booking/add_booking_entity.dart';
import 'package:mobile_customer/domain/entities/default_response.dart';
import 'package:mobile_customer/domain/entities/history_booking/history_booking_entity/history_booking_entity.dart';
import 'package:mobile_customer/domain/entities/schedule_entity.dart/schedule_entity/schedule_entity.dart';

abstract class BookingRepository {
  Future<Either<DefaultResponse, AddBookingEntity>> addBooking(
      Map<String, dynamic> data);

  Future<Either<DefaultResponse, List<HistoryBookingEntity>>> historyBooking(
      Map<String, dynamic> data);

  Future<Either<DefaultResponse, List<ScheduleEntity>>> refetchSchedule(
      Map<String, dynamic> data);
}
