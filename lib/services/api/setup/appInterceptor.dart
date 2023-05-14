import 'package:dio/dio.dart';

class AppInterceptors extends InterceptorsWrapper {
  @override
  Future onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    options.headers.addAll({"Content-Type": "application/json"});
    // print("REQUEST[${options?.method}] => PATH: ${options?.path}");
    return super.onRequest(options, handler);
  }

  @override
  Future onResponse(
      Response response, ResponseInterceptorHandler handler) async {
    // print(
    //   "RESPONSE[${response?.statusCode}] => PATH: ${response?.request?.path}");
    super.onResponse(response, handler);
  }

  @override
  Future onError(DioError err, ErrorInterceptorHandler handler) async {
    //  print("ERROR[${err?.response?.statusCode}] => PATH: ${err?.request?.path}");
    super.onError(err, handler);
  }
}
