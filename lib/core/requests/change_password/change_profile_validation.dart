import 'package:mobile_customer/core/requests/base_validation.dart';
import 'package:mobile_customer/core/requests/change_password/change_password_request.dart';
import 'package:mobile_customer/core/utilities/constants/message_constant.dart';

class ChangePasswordValidation {
  static String validate(ChangePasswordRequest changePasswordRequest) {
    for (MapEntry<String, dynamic> data
        in changePasswordRequest.toMap().entries) {
      if (!BaseValidation.notEmpty(data.value.toString())) {
        switch (data.key) {
          case 'old_password':
            return MessageConstant.required("Password Lama");
          case 'new_password':
            return MessageConstant.required("Password Baru");
        }
      }
    }

    if (!BaseValidation.match(changePasswordRequest.newPassword,
        changePasswordRequest.confirmPassword)) {
      return MessageConstant.mustBe(
          "Password", "tidak sama dengan konfirmasi password");
    }

    if (!BaseValidation.lengthPassword(changePasswordRequest.newPassword)) {
      return MessageConstant.mustBe(
          "Password", "minimal 6 dan maksimal 15 karakter");
    }

    return "";
  }
}
