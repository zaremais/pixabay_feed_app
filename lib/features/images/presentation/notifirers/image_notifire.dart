import 'package:flutter_riverpod/legacy.dart';
import 'package:pixabay_image_feed/features/images/domain/usecases/get_image_usecase.dart';
import 'package:pixabay_image_feed/features/pixabay/domain/entities/image_entity.dart';

class ImagesState {
  final List<ImageEntity> items;
  final bool isLoading;
  final bool isLoadingMore;
  final bool hasMore;
  final int page;
  final String? error;

  ImagesState({
    required this.items,
    required this.isLoading,
    required this.isLoadingMore,
    required this.hasMore,
    required this.page,
    this.error,
  });

  factory ImagesState.initial() => ImagesState(
    items: [],
    isLoading: true,
    isLoadingMore: false,
    hasMore: true,
    page: 1,
  );
}

class ImagesNotifier extends StateNotifier<ImagesState> {
  final GetImagesUseCase useCase;
  final int perPage;

  ImagesNotifier({ required this.useCase, this.perPage = 20 }) : super(ImagesState.initial()) {
    // Автозагрузка: вызываем initial load прямо из конструктора
    _loadInitial();
  }

  Future<void> _loadInitial() async {
    try {
      final page = 1;
      state = ImagesState.initial(); // isLoading = true
      final items = await useCase.call(page: page, perPage: perPage);
      state = ImagesState(items: items, isLoading: false, isLoadingMore: false, hasMore: items.length == perPage, page: page);
    } catch (e) {
      state = ImagesState(items: [], isLoading: false, isLoadingMore: false, hasMore: false, page: 1, error: e.toString());
    }
  }

  Future<void> refresh() => _loadInitial();

  Future<void> loadNextPage() async {
    if (state.isLoadingMore || !state.hasMore || state.isLoading) return;

    final nextPage = state.page + 1;
    state = ImagesState(items: state.items, isLoading: false, isLoadingMore: true, hasMore: state.hasMore, page: state.page);

    try {
      final newItems = await useCase.call(page: nextPage, perPage: perPage);
      final all = [...state.items, ...newItems];
      state = ImagesState(items: all, isLoading: false, isLoadingMore: false, hasMore: newItems.length == perPage, page: nextPage);
    } catch (e) {
      state = ImagesState(items: state.items, isLoading: false, isLoadingMore: false, hasMore: state.hasMore, page: state.page, error: e.toString());
    }
  }

  void changeQuery(String q) {
    // если реализуешь фильтр — обнови репозиторий/usecase чтобы использовать query
    // Для простоты: just refresh
    refresh();
  }
}
