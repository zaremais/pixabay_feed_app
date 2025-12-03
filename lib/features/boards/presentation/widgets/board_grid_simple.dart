import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:pixabay_image_feed/features/pixabay/domain/entities/image_entity.dart';

class BoardGridSimple extends StatelessWidget {
  final List<ImageEntity> images;

  const BoardGridSimple({super.key, required this.images});

  @override
  Widget build(BuildContext context) {
    return MasonryGridView.count(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      crossAxisCount: 2,
      mainAxisSpacing: 12,
      crossAxisSpacing: 12,
      itemCount: images.length,
      itemBuilder: (_, index) {
        final img = images[index];
        return ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: Image.network(img.previewUrl, fit: BoxFit.cover),
        );
      },
    );
  }
}
