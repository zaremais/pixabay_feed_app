import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pixabay_image_feed/features/boards/presentation/providers/provider.dart';
import 'package:pixabay_image_feed/features/boards/presentation/widgets/action_menu.dart';
import 'package:pixabay_image_feed/features/boards/presentation/widgets/header_widget.dart';
import 'package:pixabay_image_feed/features/boards/presentation/widgets/people_section.dart';
import 'package:pixabay_image_feed/features/boards/presentation/widgets/sub_board_card.dart';
import 'package:pixabay_image_feed/features/pixabay/domain/entities/image_entity.dart';

class BoardScreen extends ConsumerWidget {
  const BoardScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(boardProvider);

    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: state.when(
          loading: () => const Center(
            child: CircularProgressIndicator(color: Colors.white),
          ),

          error: (err, _) => Center(
            child: Text(
              "Ошибка загрузки",
              style: TextStyle(color: Colors.red.shade300),
            ),
          ),

          data: (images) {
            final groups = _groupImages(images);

            return ListView(
              padding: const EdgeInsets.all(16),
              children: [
                const HeaderWidget(),
                const SizedBox(height: 20),
                const PeopleSection(),
                const SizedBox(height: 20),
                const ActionMenu(),
                const SizedBox(height: 30),

                const Text(
                  "Sub-boards",
                  style: TextStyle(color: Colors.white, fontSize: 18),
                ),
                const SizedBox(height: 16),

                SizedBox(
                  height: 220,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: groups.entries
                        .map(
                          (entry) => SubBoardCard(
                            title: entry.key,
                            image: entry.value,
                          ),
                        )
                        .toList(),
                  ),
                ),

                const SizedBox(height: 30),

                const Text(
                  "Pins",
                  style: TextStyle(color: Colors.white, fontSize: 18),
                ),
                const SizedBox(height: 12),
                // BoardGridSimple(images: images),
                // ...images.map((img) => BoardGridSimple(images: images)),
              ],
            );
          },
        ),
      ),
    );
  }

  Map<String, List<ImageEntity>> _groupImages(List<ImageEntity> images) {
    final groups = <String, List<ImageEntity>>{};

    for (final img in images) {
      final tag = img.tags.split(',').first.trim();
      final key = tag.isNotEmpty ? tag : img.user;
      groups.putIfAbsent(key, () => []).add(img);
    }

    return groups;
  }
}
