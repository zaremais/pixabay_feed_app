import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:injectable/injectable.dart';
import 'package:pixabay_image_feed/features/pixabay/domain/entities/image_entity.dart';
import 'package:pixabay_image_feed/features/pixabay/domain/usecases/get_image_usecase.dart';
import 'package:pixabay_image_feed/features/pixabay/presentation/notifier/providers.dart';

@injectable
class PixabayNotifier extends AsyncNotifier<List<ImageEntity>> {
  int page = 1;
  String query = ""; // Оставляем как поле класса

  String get currentQuery => query;

  @override
  Future<List<ImageEntity>> build() async {
    return _loadPage(reset: true);
  }

  Future<void> performSearch(String q) async {
    final cleanQuery = q.trim();
    if (cleanQuery.isEmpty) return;

    query = cleanQuery;
    page = 1;

    state = const AsyncLoading(); // Показываем загрузку на экране

    try {
      // Явно получаем новые данные
      final newData = await _loadPage(reset: true);

      // ВАЖНО: Передаем НОВЫЙ список (создаем копию через [...])
      // Это гарантирует, что Riverpod заметит изменение
      state = AsyncData([...newData]);
    } catch (e, st) {
      state = AsyncError(e, st);
    }
  }

  Future<List<ImageEntity>> _loadPage({bool reset = false}) async {
    final usecase = ref.read(getPixabayUsecaseProvider);
    if (reset) page = 1;

    // Используем query, который мы сохранили в классе
    final params = ImageParams(
      page: page,
      query: query.isEmpty ? "nature" : query,
      perPage: 50,
    );

    return await usecase.execute(params: params);
  }

  Future<void> loadNextPage() async {
    final currentState = state;
    if (!currentState.hasValue) return;

    final currentImages = currentState.value!;
    if (currentImages.isEmpty) return;

    page++;

    try {
      final newImages = await _loadPage();
      if (newImages.isEmpty) {
        // Если новых изображений нет, откатываем страницу
        page--;
        return;
      }

      // Добавляем новые изображения к существующим
      state = AsyncData([...currentImages, ...newImages]);
    } catch (e, st) {
      // При ошибке откатываем страницу
      page--;
      state = AsyncError(e, st);
    }
  }

  Future<void> refresh() async {
    page = 1;
    state = const AsyncLoading();
    try {
      final newData = await _loadPage(reset: true);
      state = AsyncData(newData);
    } catch (e, st) {
      state = AsyncError(e, st);
    }
  }
}
