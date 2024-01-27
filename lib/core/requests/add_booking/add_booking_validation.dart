import 'package:mobile_customer/core/requests/add_booking/add_booking_request.dart';
import 'package:mobile_customer/core/requests/base_validation.dart';
import 'package:mobile_customer/core/utilities/constants/message_constant.dart';

class AddBookingValidation {
  static String validate(AddBookingRequest addBookingRequest) {
    for (MapEntry<String, dynamic> data in addBookingRequest.toMap().entries) {
      if (!BaseValidation.notEmpty(data.value.toString())) {
        switch (data.key) {
          case 'email':
            return MessageConstant.required("Email");
          case 'password':
            return MessageConstant.required("Password");
        }
      }
    }

    if (!BaseValidation.notEmpty(addBookingRequest.orderDate.toString())) {
      return MessageConstant.required("Tanggal Order");
    }

    if (!BaseValidation.length(addBookingRequest.productId)) {
      return MessageConstant.mustBe("Jadwal", "minimal dipilih 1");
    }

    return "";
  }
}
