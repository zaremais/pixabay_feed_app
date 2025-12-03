import 'package:flutter/material.dart';
import 'package:pixabay_image_feed/features/boards/presentation/widgets/sub_board_card.dart';
import 'package:pixabay_image_feed/features/pixabay/domain/entities/image_entity.dart';

class SubBoardsSection extends StatelessWidget {
  final String title;
  final List<ImageEntity> images;
  const SubBoardsSection({
    super.key,
    required this.images,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Sub-boards",
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 16),
        SizedBox(
          height: 200,
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: [
              SubBoardCard(title: "Australia", image: images),
              SubBoardCard(title: "Brazil", image: images),
              SubBoardCard(title: "Hawaii", image: images),
            ],
          ),
        ),
      ],
    );
  }
}
