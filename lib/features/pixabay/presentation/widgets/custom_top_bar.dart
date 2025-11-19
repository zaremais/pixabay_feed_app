import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:pixabay_image_feed/core/config/themes/app_icons.dart';

class CustomTopBar extends StatefulWidget {
  const CustomTopBar({super.key});

  @override
  State<CustomTopBar> createState() => _CustomTopBarState();
}

class _CustomTopBarState extends State<CustomTopBar> {
  bool isExplore = true;

  void toggle() {
    setState(() {
      isExplore = !isExplore;
    });
  }

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(8),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 0, sigmaY: 0),
        child: Container(
          height: 130,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,

              colors: [Colors.black.withValues(alpha: 0.8), Colors.transparent],
            ),
          ),

          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _circleButton(icon: AppIcons.bell, badge: true),

              GestureDetector(
                onTap: toggle,
                child: SizedBox(
                  child: Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(),
                        decoration: BoxDecoration(
                          color: isExplore
                              ? Colors.black.withValues(alpha: 0.05)
                              : Colors.white,

                          borderRadius: BorderRadius.circular(24),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 8,
                          ),
                          child: Text(
                            "Explore",
                            style: TextStyle(
                              color: isExplore ? Colors.white : Colors.black,
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 30),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 10,
                        ),
                        decoration: BoxDecoration(
                          color: isExplore
                              ? Colors.white
                              : Colors.black.withValues(alpha: 0.05),
                          borderRadius: BorderRadius.circular(24),
                        ),
                        child: Text(
                          "For you",
                          style: TextStyle(
                            color: isExplore ? Colors.black : Colors.white,
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              _circleButton(icon: AppIcons.search),
            ],
          ),
        ),
      ),
    );
  }

  Widget _circleButton({required IconData icon, bool badge = false}) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Padding(
          padding: const EdgeInsets.all(8),
          child: Container(
            height: 40,
            width: 40,
            decoration: BoxDecoration(
              color: Colors.black45,
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: Colors.white, size: 20),
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
