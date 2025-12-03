import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';

class PagingNotifier extends StateNotifier<AsyncValue<List<int>>> {
  PagingNotifier() : super(const AsyncLoading()) {
    loadFirstPage();
  }

  int _page = 1;
  bool _isLoadingNext = false;
  final int _limit = 20;

  Future<void> loadFirstPage() async {
    _page = 1;
    final data = await _fakeFetch(_page);
    
    state = AsyncData(data);
  }

  Future<void> loadNextPage() async {
    if (_isLoadingNext) return;

    _isLoadingNext = true;

    final oldList = state.value ?? [];
    _page++;

    final newItems = await _fakeFetch(_page);
    final updated = [...oldList, ...newItems];

    state = AsyncData(updated);
    _isLoadingNext = false;
  }

  Future<void> refresh() async {
    await loadFirstPage();
  }

  Future<List<int>> _fakeFetch(int page) async {
    await Future.delayed(const Duration(seconds: 1));
    return List.generate(_limit, (i) => (page - 1) * _limit + i);
  }
}


