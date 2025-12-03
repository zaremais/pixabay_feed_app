import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:pixabay_image_feed/features/images/presentation/providers/images_provider.dart';

class ImagesScreen extends ConsumerWidget {
  const ImagesScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(imagesNotifierProvider);
    final notifier = ref.read(imagesNotifierProvider.notifier);

    return Scaffold(
      appBar: AppBar(title: const Text('Images')),
      body: NotificationListener<ScrollNotification>(
        onNotification: (scrollInfo) {
          if (scrollInfo.metrics.pixels >=
              scrollInfo.metrics.maxScrollExtent - 300) {
            notifier.loadNextPage();
          }
          return false;
        },
        child: RefreshIndicator(
          onRefresh: () => notifier.refresh(),
          child: CustomScrollView(
            slivers: [
              SliverPadding(
                padding: const EdgeInsets.all(12),
                sliver: state.isLoading
                    ? SliverFillRemaining(
                        child: Center(child: CircularProgressIndicator()),
                      )
                    : SliverMasonryGrid.count(
                        // from flutter_staggered_grid_view
                        crossAxisCount: 2,
                        mainAxisSpacing: 12,
                        crossAxisSpacing: 12,
                        childCount:
                            state.items.length + (state.isLoadingMore ? 1 : 0),
                        itemBuilder: (context, index) {
                          if (index >= state.items.length) {
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          }
                          final img = state.items[index];
                          return GestureDetector(
                            // onTap: () => _openDetail(context, img),
                            child: Image.network(
                              img.previewUrl,
                              fit: BoxFit.cover,
                            ),
                          );
                        },
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
