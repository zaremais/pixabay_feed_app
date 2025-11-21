import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:pixabay_image_feed/core/conatants/api_url.dart';
import 'package:pixabay_image_feed/core/network/dio_client.dart' as dio;
import 'package:pixabay_image_feed/core/network/intercetptors/token_interseptor.dart';

@injectable
class DioClient {
  final Dio dio;

  DioClient()
    : dio = Dio(
        BaseOptions(
          baseUrl: ApiUrls.baseUrl,
          connectTimeout: const Duration(seconds: 10),
          receiveTimeout: const Duration(seconds: 10),
        ),
      ) {
    dio.interceptors.add(TokenInterceptor());

    dio.interceptors.add(LogInterceptor(requestBody: true, responseBody: true));
  }

  Future<Response> get(
    String path, {
    Map<String, dynamic>? query,
    required Map<String, Object> queryParameters,
  }) {
    return dio.get(path, queryParameters: query);
  }
}

Future<Response> get(
  String path, {
  Map<String, dynamic>? queryParameters,
}) async {
  return await dio.get(path, queryParameters: queryParameters);
}
