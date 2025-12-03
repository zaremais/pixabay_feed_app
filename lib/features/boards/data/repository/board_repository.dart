import 'package:injectable/injectable.dart';
import 'package:pixabay_image_feed/features/boards/data/datasources/board_remote_datasource_impl.dart';
import 'package:pixabay_image_feed/features/boards/domain/repository/board_domain_repository.dart';
import 'package:pixabay_image_feed/features/pixabay/domain/entities/image_entity.dart';
import 'package:pixabay_image_feed/features/pixabay/domain/usecases/get_image_usecase.dart';

@LazySingleton(as: BoardDomainRepository)
class BoardRepositoryImpl implements BoardDomainRepository {
  final BoardRemoteDataSource remote;

  BoardRepositoryImpl({required this.remote});

  @override
  Future<List<ImageEntity>> getBoard(ImageParams params) async {
    final models = await remote.fetchBoard(params: params);
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
