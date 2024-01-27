class BaseValidation {
  static bool notEmpty(String data) {
    return data.isNotEmpty;
  }

  static bool validEmail(String data) {
    return RegExp(r"[a-zA-Z0-9]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(data);
  }

  static bool matchPhoneNumber(String data) {
    return RegExp(r"^62[0-9]{9,10}").hasMatch(data);
  }

  static bool validLengthPhoneNumber(String data) {
    return data.length >= 10 && data.length <= 15;
  }

  static bool match(String data, String comparison) {
    return data == comparison;
  }

  static bool lengthPassword(String data) {
    return data.length >= 6 && data.length <= 15;
  }

  static bool length(List data) {
    return data.isNotEmpty;
  }
}
