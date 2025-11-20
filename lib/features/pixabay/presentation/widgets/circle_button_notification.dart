import 'package:flutter/material.dart';
import 'package:pixabay_image_feed/core/config/themes/app_icons.dart';

class CircleButtonNotification extends StatelessWidget {
  final IconData icon;
  final bool badge;
  const CircleButtonNotification({
    super.key,
    required this.icon,
    required this.badge,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Padding(
          padding: const EdgeInsets.all(10),
          child: Container(
            height: 40,
            width: 40,
            decoration: BoxDecoration(
              color: Colors.white10,

              shape: BoxShape.circle,
            ),
            child: Icon(AppIcons.bell, color: Colors.white, size: 20),
          ),
        ),

        if (badge)
          Positioned(
            right: 20,
            top: 15,
            child: Container(
              width: 10,
              height: 10,
              decoration: const BoxDecoration(
                color: Colors.red,
                shape: BoxShape.circle,
              ),
            ),
          ),
      ],
    );
  }
}
