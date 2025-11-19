import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:injectable/injectable.dart';
import 'package:pixabay_image_feed/core/network/dio_client.dart';
import 'package:pixabay_image_feed/features/pixabay/domain/usecases/get_image_usecase.dart';

import '../models/image_model.dart';

abstract class PixabayRemoteDataSource {
  Future<List<ImageModel>> fetchImages({ImageParams params, int perPage = 20});
}

@LazySingleton(as: PixabayRemoteDataSource)
class PixabayRemoteDataSourceImpl implements PixabayRemoteDataSource {
  final DioClient client;
  final String apiKey = dotenv.env['PIXABAY_KEY'] ?? '';

  PixabayRemoteDataSourceImpl({required this.client});

  @override
  Future<List<ImageModel>> fetchImages({
    ImageParams? params,
    int perPage = 20,
  }) async {
    if (params!.page < 1) {
      throw ArgumentError('page must be >= 1');
    }

    try {
      final response = await client.get(
        '',
        queryParameters: {
          'key': apiKey,
          'q': params.query,
          'image_type': 'photo',
          'page': params.page,
        },
      );

      if (response.statusCode == 200) {
        final data = response.data as Map<String, dynamic>;
        final hits = data['hits'] as List<dynamic>;
        return hits
            .map((e) => ImageModel.fromJson(Map<String, dynamic>.from(e)))
            .toList();
      } else {
        throw Exception(
          'Server error: ${response.statusCode} - ${response.data}',
        );
      }
    } on DioException catch (e) {
      final status = e.response?.statusCode;
      final serverMessage = e.response?.data?.toString() ?? e.message;

      if (status == 400) {
        if (serverMessage.toString().toLowerCase().contains('page')) {
          return [];
        }
      }

      throw Exception(
        'Network error${status != null ? ' (status $status)' : ''}: $serverMessage',
      );
    }
  }
}
