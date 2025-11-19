import 'package:pixabay_image_feed/features/pixabay/domain/entities/image_entity.dart';
import 'package:pixabay_image_feed/features/pixabay/domain/usecases/get_image_usecase.dart';

abstract class PixabayDomainRepository {
  Future<List<ImageEntity>> getImage(ImageParams params);
}
