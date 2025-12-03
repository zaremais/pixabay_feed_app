import 'package:pixabay_image_feed/features/pixabay/domain/entities/image_entity.dart';

abstract class ImagesRepository {
  Future<List<ImageEntity>> fetchImages({ required int page, required int perPage, String query });
}

class ImagesRepositoryImpl implements ImagesRepository {
  // real: Dio client injected via ctor
  @override
  Future<List<ImageEntity>> fetchImages({required int page, required int perPage, String query = ''}) async {
    // вызов API, парсинг → ImageEntity
    // для примера — имитация задержки и возврат моков
    await Future.delayed(const Duration(milliseconds: 500));
    return List.generate(perPage, (i) {
      final id = (page - 1) * perPage + i;
      return ImageEntity(
        id: id,
        previewUrl: 'https://picsum.photos/300/400?random=$id',
        largeImageUrl: 'https://picsum.photos/600/800?random=$id',
        user: 'User $id',
        tags: 'nature,tag$id',
      );
    });
  }
}
