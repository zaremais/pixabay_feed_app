import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:pixabay_image_feed/features/pixabay/presentation/notifier/image_notifire.dart';
import 'package:pixabay_image_feed/features/pixabay/presentation/widgets/custom_top_bar.dart';

class PixabayScreen extends ConsumerStatefulWidget {
  const PixabayScreen({super.key});

  @override
  ConsumerState<PixabayScreen> createState() => _PixabayScreenState();
}

class _PixabayScreenState extends ConsumerState<PixabayScreen> {
  final ScrollController controller = ScrollController();

  @override
  void initState() {
    super.initState();

    controller.addListener(() {
      if (controller.position.pixels >
          controller.position.maxScrollExtent - 300) {
        ref.read(imageListProvider.notifier).loadNextPage();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(imageListProvider);

    return Scaffold(
      body: SafeArea(
        child: state.when(
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (err, st) => Center(
            child: Text(
              "Ошибка: $err",
              style: const TextStyle(color: Colors.white),
            ),
          ),
          data: (images) {
            return Stack(
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(54),
                      topRight: Radius.circular(54),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: MasonryGridView.count(
                      controller: controller,
                      crossAxisCount: 2,
                      mainAxisSpacing: 8,
                      crossAxisSpacing: 16,
                      itemCount: images.length + 1,
                      itemBuilder: (context, index) {
                        if (index == images.length) {
                          return state.isLoading
                              ? const Padding(
                                  padding: EdgeInsets.all(12),
                                  child: Center(
                                    child: CircularProgressIndicator(),
                                  ),
                                )
                              : const SizedBox();
                        }

                        final img = images[index];
                        final tags = img.tags.split(',');

                        return ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: IntrinsicHeight(
                            child: Stack(
                              fit: StackFit.expand,
                              children: [
                                Image.network(
                                  img.previewUrl,
                                  fit: BoxFit.cover,
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
                                          Colors.black.withValues(alpha: 0.9),
                                          Colors.transparent,
                                        ],
                                      ),
                                    ),
                                  ),
                                ),

                                Positioned(
                                  bottom: 12,
                                  left: 12,
                                  right: 12,
                                  child: Text(
                                    tags.isNotEmpty
                                        ? tags.first
                                        : 'Beautiful Image',
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 13,
                                      fontWeight: FontWeight.w400,
                                    ),
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),

                Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: Container(
                    height: 50,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.bottomCenter,
                        end: Alignment.topCenter,
                        colors: [
                          Colors.black.withValues(alpha: 0.8),
                          Colors.transparent,
                        ],
                        stops: [0.0, 0.6],
                      ),
                    ),
                  ),
                ),

                Positioned(top: 0, left: 0, right: 0, child: CustomTopBar()),
              ],
            );
          },
        ),
      ),
    );
  }
}
