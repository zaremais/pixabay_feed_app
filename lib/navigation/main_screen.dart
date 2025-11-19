import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pixabay_image_feed/core/config/themes/app_colors.dart';
import 'package:pixabay_image_feed/core/enum/nav_item.dart';
import 'package:pixabay_image_feed/navigation/nav_config.dart';
import 'package:pixabay_image_feed/navigation/nav_provider.dart';

class MainScreen extends ConsumerWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final nav = ref.watch(bottomNavProvider);

    final controller = ref.watch(pageControllerProvider);

    return Scaffold(
      body: PageView(
        controller: controller,
        physics: const BouncingScrollPhysics(),
        onPageChanged: (page) {
          ref.read(bottomNavProvider.notifier).state = NavItem.values[page];
        },
        children: navConfig.map((e) => e.screen).toList(),
      ),

      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: AppColors.backgroundBlack,
        selectedItemColor: AppColors.selected,
        selectedIconTheme: IconThemeData(color: AppColors.selected),
        unselectedItemColor: AppColors.backgroundWhite,
        currentIndex: NavItem.values.indexOf(nav),

        onTap: (value) {
          controller.jumpToPage(value);
          ref.read(bottomNavProvider.notifier).state = NavItem.values[value];
        },
        items: navConfig.map((e) => e.barItem).toList(),
      ),
    );
  }
}
