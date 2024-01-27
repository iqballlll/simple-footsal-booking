import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:mobile_customer/core/routes/app_router.dart';
import 'package:mobile_customer/core/theme/color_schemes.dart';
import 'package:mobile_customer/data/local/local_data_source.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  initializeDateFormatting('id');

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  static final router = AppRouter();
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('id'),
      ],
      locale: const Locale('id'),
      debugShowCheckedModeBanner: false,
      routerConfig: router.config(
          deepLinkBuilder: (deepLink) async => DeepLink([await initCheck()])),
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: lightColorScheme,
        useMaterial3: false,
      ),
    );
  }

  Future<PageRouteInfo<dynamic>> initCheck() async {
    if (!await LocalDataSource.isExistData(key: "token")) {
      return const LoginRoute();
    } else {
      return const HomeRoute();
    }
  }
}
