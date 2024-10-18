import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent_bottom_nav_bar_v2.dart';
import 'package:tickit/calendar/view/calendar_screen.dart';
import 'package:tickit/home/home_screen.dart';
import 'package:tickit/setting/view/setting_screen.dart';
import 'package:tickit/ticket/view/ticket_screen.dart';

class NavBar extends StatefulWidget {
  const NavBar({super.key});

  @override
  State<NavBar> createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {
  List<PersistentTabConfig> _tabs() => [
        PersistentTabConfig(
          screen: const HomeScreen(),
          item: itemConfig(iconPath: "assets/icon/home.svg"),
        ),
        PersistentTabConfig(
          screen: const TicketScreen(),
          item: itemConfig(iconPath: "assets/icon/plus-square.svg"),
        ),
        PersistentTabConfig(
          screen: const CalendarScreen(),
          item: itemConfig(iconPath: "assets/icon/calendar.svg"),

        ),
        PersistentTabConfig(
          screen: const SettingScreen(),
          item: itemConfig(iconPath: "assets/icon/settings.svg"),

        ),
      ];

  ItemConfig itemConfig({required String iconPath}) {
    return ItemConfig(
      icon: SvgPicture.asset(
        iconPath,
        color: Colors.black.withOpacity(0.8),
      ),
      inactiveIcon: SvgPicture.asset(
        iconPath,
        color: Colors.black.withOpacity(0.6),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return PersistentTabView(
      navBarHeight: 70,
      tabs: _tabs(),
      navBarBuilder: (navBarConfig) => Style6BottomNavBar(
        navBarConfig: navBarConfig,
        navBarDecoration: const NavBarDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(24),
            topRight: Radius.circular(24),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              spreadRadius: 0,
              blurRadius: 2,
              offset: Offset(0, -1),
            )
          ],
        ),
      ),
    );
  }
}
