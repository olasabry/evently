import 'package:evently/app_theme.dart';
import 'package:evently/create_event_screen.dart';
import 'package:evently/nav_bar_icon.dart';
import 'package:evently/tabs/home/home_tab.dart';
import 'package:evently/tabs/love/love_tab.dart';
import 'package:evently/tabs/map/map_tab.dart';
import 'package:evently/tabs/profile/profile_tab.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  static const String routeName = "/home";

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int currentIndex = 0;

  List<Widget> tabs = [HomeTab(), MapTab(), LoveTab(), ProfileTab()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: tabs[currentIndex],

      bottomNavigationBar: BottomAppBar(
        shape: CircularNotchedRectangle(),
        notchMargin: 5,
        clipBehavior: Clip.antiAlias,
        padding: EdgeInsets.zero,
        color: AppTheme.primary,
        elevation: 0,
        child: BottomNavigationBar(
          currentIndex: currentIndex,

          onTap: (index) {
            if (currentIndex == index) return;
            currentIndex = index;
            setState(() {});
          },

          items: [
            BottomNavigationBarItem(
              icon: NavBarIcon(imageName: "Home"),
              activeIcon: NavBarIcon(imageName: "home_active"),
              label: "Home",
            ),

            BottomNavigationBarItem(
              icon: NavBarIcon(imageName: "Map"),
              activeIcon: NavBarIcon(imageName: "map_active"),
              label: "Map",
            ),

            BottomNavigationBarItem(
              icon: NavBarIcon(imageName: "love"),
              activeIcon: NavBarIcon(imageName: "love_active"),
              label: "Love",
            ),

            BottomNavigationBarItem(
              icon: NavBarIcon(imageName: "profile"),
              activeIcon: NavBarIcon(imageName: "profile_active"),
              label: "Profile",
            ),
          ],
        ),
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).pushNamed(CreateEventScreen.routeName);
        },

        child: Icon(Icons.add, size: 36),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
