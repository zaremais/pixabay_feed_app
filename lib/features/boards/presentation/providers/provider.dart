import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pixabay_image_feed/core/network/dio_client.dart';
import 'package:pixabay_image_feed/features/boards/data/datasources/board_remote_datasource_impl.dart';
import 'package:pixabay_image_feed/features/boards/data/repository/board_repository.dart';
import 'package:pixabay_image_feed/features/boards/domain/repository/board_domain_repository.dart';
import 'package:pixabay_image_feed/features/boards/domain/usecases/get_board_use_case.dart';
import 'package:pixabay_image_feed/features/boards/presentation/providers/board_notifire.dart';
import 'package:pixabay_image_feed/features/pixabay/domain/entities/image_entity.dart';

final dioClientProvider = Provider<DioClient>((ref) {
  return DioClient();
});

final boardRemoteDataSourceProvider = Provider<BoardRemoteDataSource>((ref) {
  return BoardRemoteDataSourceImpl(ref.watch(dioClientProvider));
});

final boardRepositoryProvider = Provider<BoardDomainRepository>((ref) {
  return BoardRepositoryImpl(remote: ref.watch(boardRemoteDataSourceProvider));
});

final getBoardUsecaseProvider = Provider<GetBoardUseCase>((ref) {
  return GetBoardUseCase(repository: ref.watch(boardRepositoryProvider));
});

// final boardProvider =
//     StateNotifierProvider<BoardNotifier, BaseState<List<ImageEntity>>>(
//       (ref) =>
//           BoardNotifier(getBoardUseCase: ref.watch(getBoardUsecaseProvider)),
//     );
final boardProvider =
    AsyncNotifierProvider.autoDispose<BoardNotifier, List<ImageEntity>>(
      BoardNotifier.new,
    );

