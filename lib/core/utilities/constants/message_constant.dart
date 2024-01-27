class MessageConstant {
  static String connectionTimeout = "Waktu koneksi habis, silakan coba lagi";
  static String sendTimeout = "Waktu kirim habis, silakan coba lagi";
  static String receiveTimeout = "Waktu kirim habis, silakan coba lagi";
  static String badResponse = "Tidak dapat menerima response";
  static String unknown = "Terjadi error, silakan coba lagi";

  static String required(String data) {
    return "$data tidak boleh kosong";
  }

  static String notValid(String data) {
    return "$data tidak valid";
  }

  static String mustBe(String data, String condition) {
    return "$data $condition";
  }
}
