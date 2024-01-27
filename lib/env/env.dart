// lib/env/env.dart
import 'package:envied/envied.dart';

part 'env.g.dart';

@Envied(path: '.env.prod')
abstract class Env {
  @EnviedField(
    varName: 'baseUrl',
    obfuscate: true,
    defaultValue: "http://103.152.119.203:9090/api/v1/customer",
  )
  static String baseUrl = _Env.baseUrl;
}
