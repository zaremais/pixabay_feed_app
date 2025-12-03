import 'package:flutter/material.dart';
import 'package:pixabay_image_feed/core/config/themes/app_icons.dart';
import 'package:pixabay_image_feed/features/boards/presentation/screens/board_screen.dart';
import 'package:pixabay_image_feed/features/home/presentation/screens/home_screen.dart';
import 'package:pixabay_image_feed/features/images/presentation/screens/images_screen.dart';
import 'package:pixabay_image_feed/features/pixabay/presentation/screens/inifiniti_screen.dart';

class NavConfig {
  final Widget screen;
  final BottomNavigationBarItem barItem;

  const NavConfig({required this.screen, required this.barItem});
}

final navConfig = [
  NavConfig(
    screen: const HomeScreen(),
    barItem: BottomNavigationBarItem(
      icon: Icon(AppIcons.home, size: 24),
      label: "Home",
    ),
  ),
  NavConfig(
    screen: Center(child: BoardScreen()),
    barItem: BottomNavigationBarItem(
      icon: Icon(AppIcons.grid),
      label: "Boards",
    ),
  ),

  NavConfig(
    screen: const Center(child: InfiniteListScreen()),
    barItem: BottomNavigationBarItem(
      icon: Image.asset('assets/images/tabadd.png'),
      label: "",
    ),
  ),
  NavConfig(
    screen: const Center(child: ImagesScreen()),
    barItem: BottomNavigationBarItem(
      icon: Icon(AppIcons.message, size: 34),
      label: "Messages",
    ),
  ),
  NavConfig(
    screen: const Center(child: Text("Profile Screen")),
    barItem: BottomNavigationBarItem(
      icon: Image.asset('assets/images/profilem.png', width: 30, height: 30),
      label: "Profile",
    ),
  ),
];
