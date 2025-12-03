import 'package:flutter/material.dart';
import 'package:pixabay_image_feed/features/boards/presentation/widgets/grid_4_images.dart';
import 'package:pixabay_image_feed/features/pixabay/domain/entities/image_entity.dart';

class SubBoardCard extends StatelessWidget {
 final List<ImageEntity> image;
 final String title;
  const SubBoardCard({super.key, required this.image, required this.title,});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(right: 16),
      width: 130,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Grid4Images(images: image),
          const SizedBox(height: 8),
          Text(
            title,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            "${image.length} pins",
            style: const TextStyle(color: Colors.white54, fontSize: 12),
          ),
        ],
      ),
    );
  }
}
