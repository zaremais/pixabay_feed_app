import 'package:pixabay_image_feed/features/images/data/images_repository.dart';
import 'package:pixabay_image_feed/features/pixabay/domain/entities/image_entity.dart';

class GetImagesUseCase {
  final ImagesRepository repo;
  GetImagesUseCase(this.repo);

  Future<List<ImageEntity>> call({required int page, required int perPage, String query = ''}) {
    return repo.fetchImages(page: page, perPage: perPage, query: query);
  }
}
