import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:pixabay_image_feed/features/pixabay/domain/entities/image_entity.dart';
import 'package:pixabay_image_feed/features/pixabay/presentation/widgets/image_item.dart';
import 'package:pixabay_image_feed/features/pixabay/presentation/widgets/loading_indicator.dart';

import 'empty_image_state.dart';

class ImageGrid extends ConsumerWidget {
  final List<ImageEntity> images;
  final ScrollController scrollController;
  final bool isLoadingNext;
  final TextEditingController searchController;
  final AsyncCallback onRefresh;
  final ValueChanged<ImageEntity> onImageTap;
  final AsyncCallback loadNextPage;

  const ImageGrid({
    super.key,
    required this.images,
    required this.scrollController,
    required this.isLoadingNext,
    required this.searchController,
    required this.onRefresh,
    required this.onImageTap,
    required this.loadNextPage,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    if (images.isEmpty) {
      return EmptyImageState(searchController: searchController);
    }

    return RefreshIndicator(
      onRefresh: onRefresh,
      backgroundColor: Colors.black,
      color: Colors.white,
      child: Stack(
        children: [
          MasonryGridView.count(
            controller: scrollController,

            crossAxisCount: 2,
            mainAxisSpacing: 12,
            crossAxisSpacing: 12,
            itemCount: images.length + (isLoadingNext ? 1 : 0),
            itemBuilder: (context, index) {
              if (index == images.length && isLoadingNext) {
                return const LoadingGridIndicator();
              }

              final image = images[index];
              return ImageItem(
                image: image,
                index: index,
                onTap: () => onImageTap(image),
              );
            },
          ),

          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              height: 80,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                  colors: [
                    Colors.black.withValues(alpha: 0.8),
                    Colors.transparent,
                  ],
                  stops: const [0.0, 0.6],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
