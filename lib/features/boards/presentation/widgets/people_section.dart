import 'package:flutter/material.dart';
import 'package:pixabay_image_feed/features/boards/presentation/widgets/avatar.dart';

class PeopleSection extends StatelessWidget {
  const PeopleSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Avatar(url: "https://i.pravatar.cc/100?img=1"),
            Avatar(url: "https://i.pravatar.cc/100?img=2"),
            Avatar(url: "https://i.pravatar.cc/100?img=3"),
            AddAvatar(),
          ],
        ),
        const SizedBox(height: 8),
        const Text(
          "Secret board",
          style: TextStyle(color: Colors.white60, fontSize: 14),
        ),
      ],
    );
  }
}
