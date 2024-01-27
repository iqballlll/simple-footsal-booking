import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:mobile_customer/core/routes/app_router.dart';

@RoutePage()
class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  @override
  Widget build(BuildContext context) {
    return AutoTabsRouter(
      routes: const [
        HomeRoute(),
        ScheduleRoute(),
        ProfileRoute(),
      ],
      transitionBuilder: (context, child, animation) => FadeTransition(
        opacity: animation,
        child: child,
      ),
      builder: (context, child) {
        final tabsRouter = AutoTabsRouter.of(context);

        return Scaffold(
          body: child,
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: tabsRouter.activeIndex,
            onTap: (index) {
              tabsRouter.setActiveIndex(index);
            },
            items: const [
              BottomNavigationBarItem(
                label: 'Beranda',
                icon: Icon(Icons.home),
              ),
              BottomNavigationBarItem(
                label: 'Jadwal Main',
                icon: Icon(Icons.calendar_month_rounded),
              ),
              BottomNavigationBarItem(
                label: 'Profil',
                icon: Icon(Icons.manage_accounts),
              ),
            ],
          ),
        );
      },
    );
  }
}
