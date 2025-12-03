import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:pixabay_image_feed/core/network/dio_client.dart';
import 'package:pixabay_image_feed/features/pixabay/data/datasourses/pixabay_remote_data_source.dart';
import 'package:pixabay_image_feed/features/pixabay/data/repositories/pixabay_repository._impl.dart';
import 'package:pixabay_image_feed/features/pixabay/domain/entities/image_entity.dart';
import 'package:pixabay_image_feed/features/pixabay/domain/repositories/pixabay_domain_repository.dart';
import 'package:pixabay_image_feed/features/pixabay/domain/usecases/get_image_usecase.dart';
import 'package:pixabay_image_feed/features/pixabay/presentation/notifier/paging_notifire.dart';
import 'package:pixabay_image_feed/features/pixabay/presentation/notifier/pixabay_notifire.dart';

final dioClientProvider = Provider<DioClient>((ref) {
  return DioClient();
});

final pixabayRemoteDataSourceProvider = Provider<PixabayRemoteDataSource>((
  ref,
) {
  final dioClient = ref.watch(dioClientProvider);
  return PixabayRemoteDataSourceImpl(dioClient);
});

final pixabayRepositoryProvider = Provider<PixabayDomainRepository>((ref) {
  final remote = ref.watch(pixabayRemoteDataSourceProvider);
  return PixabayRepositoryImpl(remote: remote);
});

final getPixabayUsecaseProvider = Provider<GetImageUsecase>((ref) {
  final repo = ref.watch(pixabayRepositoryProvider);
  return GetImageUsecase(repository: repo);
});



final pixabayProvider =
    AsyncNotifierProvider<PixabayNotifier, List<ImageEntity>>(
      PixabayNotifier.new,
    );

final pagingProvider =
    StateNotifierProvider<PagingNotifier, AsyncValue<List<int>>>(
      (ref) => PagingNotifier(),
    );

