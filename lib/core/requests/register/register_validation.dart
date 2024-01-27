import 'package:mobile_customer/core/requests/base_validation.dart';
import 'package:mobile_customer/core/requests/register/register_request.dart';
import 'package:mobile_customer/core/utilities/constants/message_constant.dart';

class RegisterValidation {
  static String validate(RegisterRequest registerRequest) {
    for (MapEntry<String, dynamic> data in registerRequest.toMap().entries) {
      if (!BaseValidation.notEmpty(data.value.toString())) {
        switch (data.key) {
          case 'name':
            return MessageConstant.required("Nama");
          case 'email':
            return MessageConstant.required("Email");
          case 'phone':
            return MessageConstant.required("Nomor Telepon");
          case 'address':
            return MessageConstant.required("Alamat");
          case 'password':
            return MessageConstant.required("Password");
          case 'confirmPassword':
            return MessageConstant.required("Konfirmasi Password");
        }
      }
    }

    if (!BaseValidation.validEmail(registerRequest.email)) {
      return MessageConstant.notValid("Email");
    }

    if (!BaseValidation.matchPhoneNumber(registerRequest.phone)) {
      return MessageConstant.mustBe("No Telepon", "harus diawali 62");
    }

    if (!BaseValidation.validLengthPhoneNumber(registerRequest.phone)) {
      return MessageConstant.mustBe(
          "No Telepon", "minimal 10 dan maksimal 15 karakter");
    }

    if (!BaseValidation.match(
        registerRequest.password, registerRequest.confirmPassword)) {
      return MessageConstant.mustBe(
          "Password", "tidak sama dengan konfirmasi password");
    }

    if (!BaseValidation.lengthPassword(registerRequest.password)) {
      return MessageConstant.mustBe(
          "Password", "minimal 6 dan maksimal 15 karakter");
    }

    return "";
  }
}
