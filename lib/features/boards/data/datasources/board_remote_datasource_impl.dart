import 'package:injectable/injectable.dart';
import 'package:pixabay_image_feed/core/network/dio_client.dart';
import 'package:pixabay_image_feed/features/pixabay/data/models/image_model.dart';
import 'package:pixabay_image_feed/features/pixabay/domain/usecases/get_image_usecase.dart';

abstract class BoardRemoteDataSource {
  Future<List<ImageModel>> fetchBoard({required ImageParams params});
}


@LazySingleton(as: BoardRemoteDataSource)
class BoardRemoteDataSourceImpl implements BoardRemoteDataSource {
  final DioClient dio;

  BoardRemoteDataSourceImpl(this.dio);

  @override
  Future<List<ImageModel>> fetchBoard({required ImageParams params}) async {
    final response = await dio.get(
      '',

      queryParameters: {
       'key': '53269556-6855e75de2067b5b347be6978',
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
