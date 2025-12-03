import 'package:flutter/material.dart';
import 'package:pixabay_image_feed/features/pixabay/domain/entities/image_entity.dart';

class Grid4Images extends StatelessWidget {
  final List<ImageEntity> images;
  const Grid4Images({super.key, required this.images});

  @override
  Widget build(BuildContext context) {
    final thumbs = images.take(4).toList();
    return SizedBox(
      height: 150,
      child: GridView.count(
        crossAxisCount: 2,
        mainAxisSpacing: 5,
        crossAxisSpacing: 5,
        physics: const NeverScrollableScrollPhysics(),
        children: thumbs.map((img) {
          return ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Image.network(img.previewUrl, fit: BoxFit.cover),
          );
        }).toList(),
      ),
    );
  }
}
