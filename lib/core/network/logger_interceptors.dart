import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:logger/logger.dart';

@injectable
class LoggerInterceptor extends Interceptor {
  final Logger logger = Logger(
    printer: PrettyPrinter(methodCount: 0, printEmojis: true),
  );

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    logger.i("--> ${options.method} ${options.uri}");
    logger.d("Headers: ${options.headers}");
    logger.d('Query: ${options.queryParameters}');
    logger.d("Data: ${options.data}");
    super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    logger.i("<-- ${response.statusCode} ${response.requestOptions.uri}");
    logger.d("Response: ${response.data}");
    super.onResponse(response, handler);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    logger.e(
      "ERROR[${err.response?.statusCode}] => URL: ${err.requestOptions.uri}",
    );
    logger.e("${err.message}");
    super.onError(err, handler);
  }
}
