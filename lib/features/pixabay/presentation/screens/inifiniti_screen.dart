import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pixabay_image_feed/features/pixabay/presentation/notifier/providers.dart';

class InfiniteListScreen extends ConsumerStatefulWidget {
  const InfiniteListScreen({super.key});

  @override
  ConsumerState<InfiniteListScreen> createState() => _InfiniteListScreenState();
}

class _InfiniteListScreenState extends ConsumerState<InfiniteListScreen> {
  final _controller = ScrollController();

  @override
  void initState() {
    super.initState();
    _controller.addListener(_onScroll);
  }

  void _onScroll() {
    if (_controller.position.pixels >
        _controller.position.maxScrollExtent - 300) {
      ref.read(pagingProvider.notifier).loadNextPage();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(pagingProvider);

    return Scaffold(
      appBar: AppBar(title: const Text("Infinite list")),

      body: state.when(
        loading: () => const Center(child: CircularProgressIndicator()),

        error: (e, _) => Text("Ошибка: $e"),

        data: (items) => RefreshIndicator(
          onRefresh: ref.read(pagingProvider.notifier).refresh,
          child: ListView.builder(
            controller: _controller,
            itemCount: items.length + 1,
            itemBuilder: (context, index) {
              if (index == items.length) {
                return const Padding(
                  padding: EdgeInsets.all(16),
                  child: Center(child: CircularProgressIndicator()),
                );
              }

              return ListTile(title: Text("Item ${items[index]}"));
            },
          ),
        ),
      ),
    );
  }
}
