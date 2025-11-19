import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pixabay_image_feed/features/pixabay/domain/entities/image_entity.dart';
import 'package:pixabay_image_feed/features/pixabay/domain/usecases/get_image_usecase.dart';
import 'package:pixabay_image_feed/features/pixabay/presentation/notifier/providers.dart';

class ImagesNotifier extends AsyncNotifier<List<ImageEntity>> {
  int page = 1;
  String query = "";

  @override
  Future<List<ImageEntity>> build() async {
    return _loadPage(reset: true);
  }

  Future<List<ImageEntity>> _loadPage({bool reset = false}) async {
    final usecase = ref.read(getImagesUsecaseProvider);

    if (reset) {
      page = 1;
    }

    final params = ImageParams(page: page, query: query);
    final newData = await usecase.execute(params: params);

    if (reset) return newData;

    return [...state.value ?? [], ...newData];
  }

  Future<void> loadNextPage() async {
    page++;
    final data = await _loadPage();
    state = AsyncData(data);
  }

  Future<void> changeQuery(String q) async {
    query = q;
    state = const AsyncLoading();
    state = AsyncData(await _loadPage(reset: true));
  }
}

final imageListProvider =
    AsyncNotifierProvider<ImagesNotifier, List<ImageEntity>>(
      ImagesNotifier.new,
    );
