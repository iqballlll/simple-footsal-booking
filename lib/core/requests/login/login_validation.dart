import 'package:mobile_customer/core/requests/base_validation.dart';
import 'package:mobile_customer/core/requests/login/login_request.dart';
import 'package:mobile_customer/core/utilities/constants/message_constant.dart';

class LoginValidation {
  static String validate(LoginRequest loginRequest) {
    for (MapEntry<String, dynamic> data in loginRequest.toMap().entries) {
      if (!BaseValidation.notEmpty(data.value.toString())) {
        switch (data.key) {
          case 'email':
            return MessageConstant.required("Email");
          case 'password':
            return MessageConstant.required("Password");
        }
      }
    }

    if (!BaseValidation.validEmail(loginRequest.email)) {
      return MessageConstant.notValid("Email");
    }

    if (!BaseValidation.lengthPassword(loginRequest.password)) {
      return MessageConstant.mustBe(
          "Password", "minimal 6 dan maksimal 15 karakter");
    }

    return "";
  }
}
