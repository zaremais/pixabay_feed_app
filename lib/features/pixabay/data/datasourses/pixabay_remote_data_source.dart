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
       
        'q': params.query.isEmpty ? 'nature' : params.query,
        'image_type': 'photo',
        'page': params.page,
        'per_page': params.perPage,
      },
    );
  
    final data = response.data as Map<String, dynamic>;
    final hits = data['hits'] as List<dynamic>;
    return hits.map((json) => ImageModel.fromJson(json)).toList();
  }
}
