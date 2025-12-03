import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:injectable/injectable.dart';
import 'package:pixabay_image_feed/features/boards/domain/usecases/get_board_use_case.dart';
import 'package:pixabay_image_feed/features/boards/presentation/providers/provider.dart';
import 'package:pixabay_image_feed/features/pixabay/domain/entities/image_entity.dart';
import 'package:pixabay_image_feed/features/pixabay/domain/usecases/get_image_usecase.dart';

@injectable
class BoardNotifier extends AsyncNotifier<List<ImageEntity>> {
  late final GetBoardUseCase _useCase;

  @override
  Future<List<ImageEntity>> build() async {
    _useCase = ref.watch(getBoardUsecaseProvider);

    return _useCase.execute(
      params: ImageParams(page: 1, perPage: 40, query: "nature"),
    );
  }

  Future<void> reload(String query) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      return _useCase.execute(
        params: ImageParams(page: 1, perPage: 40, query: query),
      );
    });
  }
}
