import 'package:auto_route/auto_route.dart';
import 'package:mobile_customer/feature/add_booking/add_booking_screen.dart';
import 'package:mobile_customer/feature/booking/booking_screen.dart';
import 'package:mobile_customer/feature/change_password/change_password_screen.dart';
import 'package:mobile_customer/feature/change_profile/change_profile_screen.dart';
import 'package:mobile_customer/feature/history/history_screen.dart';
import 'package:mobile_customer/feature/home/home_screen.dart';
import 'package:mobile_customer/feature/login/login_screen.dart';
import 'package:mobile_customer/feature/main/main_screen.dart';
import 'package:mobile_customer/feature/profile/profile_screen.dart';
import 'package:mobile_customer/feature/register/register_screen.dart';
import 'package:mobile_customer/feature/schedule/schedule_screen.dart';
part 'app_router.gr.dart';

@AutoRouterConfig(replaceInRouteName: 'Screen,Route')
class AppRouter extends _$AppRouter {
  @override
  List<AutoRoute> get routes => [
        AutoRoute(
          initial: true,
          page: LoginRoute.page,
        ),
        AutoRoute(
          page: RegisterRoute.page,
        ),
        AutoRoute(
          page: AddBookingRoute.page,
        ),
        AutoRoute(
          page: HistoryRoute.page,
        ),
        AutoRoute(
          page: ChangeProfileRoute.page,
        ),
        AutoRoute(
          page: ChangePasswordRoute.page,
        ),
        AutoRoute(
          page: MainRoute.page,
          children: [
            AutoRoute(
              page: HomeRoute.page,
            ),
            AutoRoute(
              page: ScheduleRoute.page,
            ),
            AutoRoute(
              page: ProfileRoute.page,
            ),
          ],
        ),
      ];
}
