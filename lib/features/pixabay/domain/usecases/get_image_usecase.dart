import 'package:injectable/injectable.dart';
import 'package:pixabay_image_feed/core/base/base_usecase.dart';
import 'package:pixabay_image_feed/core/conatants/typedefs.dart';
import 'package:pixabay_image_feed/features/pixabay/domain/entities/image_entity.dart';
import 'package:pixabay_image_feed/features/pixabay/domain/repositories/pixabay_domain_repository.dart';

@injectable
class GetImageUsecase extends BaseUsecase<List<ImageEntity>, ImageParams> {
  final PixabayDomainRepository _repository;

  GetImageUsecase({required PixabayDomainRepository repository})
    : _repository = repository;

  @override
  Future<List<ImageEntity>> execute({required ImageParams params}) async {
    return _repository.getImage(params);
  }
}

class ImageParams {
  final int page;
  final String query;
  final int perPage;

  ImageParams({required this.page, required this.query, required this.perPage});

  JSON toJson() {
    return {'page': page, 'query': query, 'per_page': perPage};
  }
}
