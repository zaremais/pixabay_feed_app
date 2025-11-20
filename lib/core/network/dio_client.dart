import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:pixabay_image_feed/core/conatants/api_url.dart';
import 'package:pixabay_image_feed/core/network/intercetptors/token_interseptor.dart';

@injectable
class DioClient {
  late final Dio dio;

  DioClient() {
    dio = Dio(
      BaseOptions(
        baseUrl: ApiUrls.baseUrl,
        connectTimeout: const Duration(seconds: 10),
        receiveTimeout: const Duration(seconds: 10),
        responseType: ResponseType.json,
      ),
    );

    dio.interceptors.add(TokenInterceptor());
  }

  Future<Response> get(
    String path, {
    Map<String, dynamic>? queryParameters,
  }) async {
    return await dio.get(path, queryParameters: queryParameters);
  }
}
