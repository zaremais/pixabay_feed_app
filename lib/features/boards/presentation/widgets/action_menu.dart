import 'package:flutter/material.dart';
import 'package:pixabay_image_feed/features/boards/presentation/widgets/circle_button.dart';

class ActionMenu extends StatelessWidget {
  const ActionMenu({super.key});

  @override
  Widget build(BuildContext context) {
    final items = [
      ("Shopping", Icons.shopping_bag),
      ("Ideas", Icons.lightbulb_outline),
      ("Organise", Icons.dashboard_customize),
      ("Notes", Icons.note_alt),
    ];
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: items.map((e) {
        return Column(
          children: [
            CircleButton(icon: e.$2),
            const SizedBox(height: 6),
            Text(
              e.$1,
              style: const TextStyle(color: Colors.white70, fontSize: 12),
            ),
          ],
        );
      }).toList(),
    );
  }
}
