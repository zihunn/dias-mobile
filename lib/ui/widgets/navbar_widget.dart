// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent_bottom_nav_bar.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:DiAs/ui/screens/search/search_screen.dart';
import 'package:DiAs/ui/styles/app_colors.dart';

import '../screens/home_screen.dart';
import '../screens/profile/profile_screen.dart';

class NavbarWidget extends StatelessWidget {
  Map<String, dynamic> userNonBloc; // Tambahkan parameter user

  NavbarWidget({
    super.key,
    required this.userNonBloc,
  });

  List<Widget> _buildScreens() {
    return [
      HomeScreen(userNonBloc: userNonBloc), // Teruskan user ke HomeScreen
      const SearchScreen(),
      ProfileScreen(
        userNonBloc: userNonBloc,
      ),
    ];
  }

  List<PersistentBottomNavBarItem> _navBarsItems() {
    return [
      PersistentBottomNavBarItem(
        icon: const Icon(Icons.home),
        title: ("Home"),
        textStyle: const TextStyle(fontWeight: FontWeight.w500),
        activeColorPrimary: AppColors.primaryColor,
        inactiveColorPrimary: Colors.grey,
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(Icons.search),
        title: ("Search"),
        activeColorPrimary: AppColors.primaryColor,
        textStyle: const TextStyle(fontWeight: FontWeight.w500),
        inactiveColorPrimary: Colors.grey,
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(Icons.person),
        title: ("Profile"),
        activeColorPrimary: AppColors.primaryColor,
        textStyle: const TextStyle(fontWeight: FontWeight.w500),
        inactiveColorPrimary: Colors.grey,
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return PersistentTabView(
      context,
      screens: _buildScreens(),
      items: _navBarsItems(),
      backgroundColor: Colors.white,
      handleAndroidBackButtonPress: true,
      resizeToAvoidBottomInset: true,
      stateManagement: true,
      decoration: NavBarDecoration(
        borderRadius: BorderRadius.circular(10.0),
        colorBehindNavBar: Colors.white,
      ),
      navBarStyle: NavBarStyle.style9,
      onItemSelected: (value) async {
        print('navbar');
        print(userNonBloc);
      },
    );
  }
}
