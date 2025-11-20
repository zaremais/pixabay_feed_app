import 'package:dio/dio.dart';
import 'package:pixabay_image_feed/core/env/env.dart';

class TokenInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    if (Env.apiKey.isEmpty) {
      handler.reject(
        DioException(
          requestOptions: options,
          error: 'API key is not configured',
        ),
      );
      return;
    }

    options.queryParameters['key'] = Env.apiKey;
    super.onRequest(options, handler);
  }
}
