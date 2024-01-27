import 'package:mobile_customer/core/requests/add_booking/add_booking_request.dart';
import 'package:mobile_customer/core/requests/base_validation.dart';
import 'package:mobile_customer/core/requests/change_profile/change_profile_request.dart';
import 'package:mobile_customer/core/utilities/constants/message_constant.dart';

class ChangeProfileValidation {
  static String validate(ChangeProfileRequest changeProfileRequest) {
    for (MapEntry<String, dynamic> data
        in changeProfileRequest.toMap().entries) {
      if (!BaseValidation.notEmpty(data.value.toString())) {
        switch (data.key) {
          case 'name':
            return MessageConstant.required("Nama");
          case 'email':
            return MessageConstant.required("Email");
          case 'address':
            return MessageConstant.required("Alamat");
          case 'phone':
            return MessageConstant.required("No Telepon");
        }
      }
    }

    if (!BaseValidation.validEmail(changeProfileRequest.email)) {
      return MessageConstant.notValid("Email");
    }

    if (!BaseValidation.matchPhoneNumber(changeProfileRequest.phone)) {
      return MessageConstant.mustBe("No Telepon", "harus diawali 62");
    }

    return "";
  }
}
