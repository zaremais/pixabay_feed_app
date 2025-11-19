import 'package:injectable/injectable.dart';
import 'package:pixabay_image_feed/features/pixabay/data/datasourses/pixabay_remote_data_source.dart';
import 'package:pixabay_image_feed/features/pixabay/domain/entities/image_entity.dart';
import 'package:pixabay_image_feed/features/pixabay/domain/repositories/pixabay_domain_repository.dart';
import 'package:pixabay_image_feed/features/pixabay/domain/usecases/get_image_usecase.dart';

@LazySingleton(as: PixabayDomainRepository)
class PixabayRepositoryImpl implements PixabayDomainRepository {
  final PixabayRemoteDataSource remote;
  PixabayRepositoryImpl({required this.remote});

  @override
  Future<List<ImageEntity>> getImage(ImageParams params) async {
    final models = await remote.fetchImages(params: params);
    return models
        .map(
          (m) => ImageEntity(
            id: m.id,
            previewUrl: m.previewUrl,
            largeImageUrl: m.largeImageUrl,
            user: m.user,
            tags: m.tags,
          ),
        )
        .toList();
  }
}
