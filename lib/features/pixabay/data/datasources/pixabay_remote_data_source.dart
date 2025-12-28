import 'package:injectable/injectable.dart';
import 'package:pixabay_image_feed/core/network/dio_client.dart';
import 'package:pixabay_image_feed/features/pixabay/domain/usecases/get_image_usecase.dart';

import '../models/image_model.dart';

abstract class PixabayRemoteDataSource {
  Future<List<ImageModel>> fetchImages({required ImageParams params});
}

@LazySingleton(as: PixabayRemoteDataSource)
class PixabayRemoteDataSourceImpl implements PixabayRemoteDataSource {
  final DioClient dio;

  PixabayRemoteDataSourceImpl(this.dio);

  @override
  Future<List<ImageModel>> fetchImages({required ImageParams params}) async {
    final response = await dio.get(
      '',
      queryParameters: {
        'q': params.query,
        'image_type': 'photo',
        'page': params.page,
        'per_page': params.perPage,
      },
    );

    if (response.data == null) {
      throw Exception('Response data is null');
    }

    final data = response.data as Map<String, dynamic>;
    
    if (!data.containsKey('hits')) {
      throw Exception('Invalid API response: missing "hits" field');
    }

    final hits = data['hits'];
    if (hits is! List) {
      throw Exception('Invalid API response: "hits" is not a list');
    }

    try {
      return hits
          .cast<Map<String, dynamic>>()
          .map((json) => ImageModel.fromJson(json))
          .toList();
    } catch (e) {
      throw Exception('Failed to parse image models: $e');
    }
  }
}
