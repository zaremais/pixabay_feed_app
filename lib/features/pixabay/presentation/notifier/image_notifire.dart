import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:injectable/injectable.dart';
import 'package:pixabay_image_feed/features/pixabay/domain/entities/image_entity.dart';
import 'package:pixabay_image_feed/features/pixabay/domain/usecases/get_image_usecase.dart';
import 'package:pixabay_image_feed/features/pixabay/presentation/notifier/providers.dart';

@injectable
class ImagesNotifier extends AsyncNotifier<List<ImageEntity>> {
  int page = 1;
  String query = "";
  bool _isLoadingNext = false;
  Timer? _debounce;

  bool get isLoadingNext => _isLoadingNext;

  @override
  Future<List<ImageEntity>> build() async {
    return _loadPage(reset: true);
  }

  Future<List<ImageEntity>> _loadPage({bool reset = false}) async {
    try {
      final usecase = ref.read(getImagesUsecaseProvider);

      if (reset) {
        page = 1;
      }

      final params = ImageParams(page: page, query: query, perPage: 50);
      final newData = await usecase.execute(params: params);

      if (reset) return newData;

      final previousState = state;
      if (previousState is AsyncData<List<ImageEntity>>) {
        return [...previousState.value, ...newData];
      }
      return newData;
    } catch (error, stackTrace) {
      state = AsyncError(error, stackTrace);
      rethrow;
    }
  }

  Future<void> loadNextPage() async {
    if (_isLoadingNext) return;
    _isLoadingNext = true;

    try {
      page++;
      final data = await _loadPage();
      state = AsyncData(data);
    } catch (error, stackTrace) {
      state = AsyncError(error, stackTrace);
      page--;
    } finally {
      _isLoadingNext = false;
    }
  }

  Future<void> refresh() async {
    state = const AsyncLoading();
    final data = await _loadPage(reset: true);
    state = AsyncData(data);
  }

  Future<void> changeQuery(String q) async {
    query = q;

    _debounce?.cancel();
    _debounce = Timer(const Duration(microseconds: 500), () async {
      state = const AsyncLoading();
      final data = await _loadPage(reset: true);
      state = AsyncData(data);
    });
  }
}

final imageListProvider =
    AsyncNotifierProvider<ImagesNotifier, List<ImageEntity>>(
      ImagesNotifier.new,
    );
