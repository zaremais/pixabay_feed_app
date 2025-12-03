import 'package:flutter/material.dart';
import 'package:pixabay_image_feed/features/boards/presentation/widgets/circle_button.dart';
import 'package:pixabay_image_feed/navigation/main_screen.dart';

class HeaderWidget extends StatelessWidget {
  const HeaderWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        CircleButton(
          icon: Icons.arrow_back_ios,
          onTap: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => MainScreen()),
            );
          },
        ),
        Text(
          'Beach travel ideas',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        Row(
          children: [
            CircleButton(icon: Icons.grid_view),
            SizedBox(width: 10),
            CircleButton(icon: Icons.more_horiz),
          ],
        ),
      ],
    );
  }
}
