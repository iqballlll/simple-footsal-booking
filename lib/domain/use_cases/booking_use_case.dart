import 'package:either_dart/either.dart';
import 'package:mobile_customer/domain/entities/add_booking/add_booking_entity.dart';
import 'package:mobile_customer/domain/entities/default_response.dart';
import 'package:mobile_customer/domain/entities/history_booking/history_booking_entity/history_booking_entity.dart';
import 'package:mobile_customer/domain/entities/schedule_entity.dart/schedule_entity/schedule_entity.dart';
import 'package:mobile_customer/domain/repositories/booking_repository.dart';

class BookingUseCase {
  BookingUseCase(this.repository);

  final BookingRepository repository;

  Future<Either<DefaultResponse, AddBookingEntity>> addBooking(
      Map<String, dynamic> payload) async {
    return await repository.addBooking(payload);
  }

  Future<Either<DefaultResponse, List<HistoryBookingEntity>>> historyBooking(
      Map<String, dynamic> payload) async {
    return await repository.historyBooking(payload);
  }

  Future<Either<DefaultResponse, List<ScheduleEntity>>> refetchSchedule(
      Map<String, dynamic> payload) async {
    return await repository.refetchSchedule(payload);
  }
}
