
import 'package:dio/dio.dart';
import 'package:flutter_starter_template/global/manager/logger.dart';

late final Dio baseApiDio;

void setupRetrofitConfig() {
  _setupBaseApiDio();
}

void _setupBaseApiDio() {
  baseApiDio = Dio();

  // timeout 설정
  baseApiDio.options.connectTimeout = const Duration(seconds: 5);
  baseApiDio.options.receiveTimeout = const Duration(seconds: 3);

  // interceptors 추가
  baseApiDio.interceptors.add(_CustomLogInterceptor());
}

class _CustomLogInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    logger.d('REQUEST[${options.method}] => PATH: ${options.path}');
    super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    logger.d(
      'RESPONSE[${response.statusCode}] => PATH: ${response.requestOptions.path}',
    );
    super.onResponse(response, handler);
  }

  @override
  void onError(DioError err, ErrorInterceptorHandler handler) {
    logger.d(
      'ERROR[${err.response?.statusCode}] => PATH: ${err.requestOptions.path}',
    );
    super.onError(err, handler);
  }
}
