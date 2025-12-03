import 'package:injectable/injectable.dart';
import 'package:pixabay_image_feed/core/base/base_usecase.dart';
import 'package:pixabay_image_feed/features/boards/domain/repository/board_domain_repository.dart';
import 'package:pixabay_image_feed/features/pixabay/domain/entities/image_entity.dart';
import 'package:pixabay_image_feed/features/pixabay/domain/usecases/get_image_usecase.dart';

@injectable
class GetBoardUseCase extends BaseUsecase<List<ImageEntity>, ImageParams> {
  final BoardDomainRepository _repository;

  GetBoardUseCase({required BoardDomainRepository repository})
    : _repository = repository;

  @override
  Future<List<ImageEntity>> execute({required ImageParams params}) async {
    return _repository.getBoard(params);
  }
}
