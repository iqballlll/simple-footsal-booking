import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class LocalDataSource {
  static FlutterSecureStorage storage = const FlutterSecureStorage();

  static Future<void> store(
      {required String key, required String value}) async {
    return await storage.write(key: key, value: value);
  }

  static Future<String?> get({required String key}) async {
    return await storage.read(key: key);
  }

  static Future<void> delete({required String key}) async {
    return await storage.delete(key: key);
  }

  static Future<bool> isExistData({required String key}) async {
    return await storage.read(key: key) != null;
  }
}
