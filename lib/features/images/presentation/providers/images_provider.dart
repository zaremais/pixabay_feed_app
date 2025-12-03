import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:pixabay_image_feed/features/images/data/images_repository.dart';
import 'package:pixabay_image_feed/features/images/domain/usecases/get_image_usecase.dart';
import 'package:pixabay_image_feed/features/images/presentation/notifirers/image_notifire.dart';

final imagesRepositoryProvider = Provider<ImagesRepository>((ref) {
  return ImagesRepositoryImpl(); // или реальная реализация с Dio
});

final getImagesUseCaseProvider = Provider<GetImagesUseCase>((ref) {
  return GetImagesUseCase(ref.read(imagesRepositoryProvider));
});

final imagesNotifierProvider = StateNotifierProvider<ImagesNotifier, ImagesState>((ref) {
  return ImagesNotifier(useCase: ref.read(getImagesUseCaseProvider));
});
