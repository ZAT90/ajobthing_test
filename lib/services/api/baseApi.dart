import 'package:ajobthing_test/services/api/setup/appInterceptor.dart';
import 'package:dio/dio.dart';


abstract class BaseApi {
  final Dio _dio = initDio();
  static Dio initDio() {
    Dio dio = Dio();
    dio.interceptors.addAll([
      AppInterceptors(),
    ]);

    // dio.options.baseUrl = ConfigReader.getBaseAPI();
    dio.options.baseUrl =
        "https://private-b9a758-candidattest.apiary-mock.com/";
    //dio.options.baseUrl = "http://54.255.32.62/api";

    // dio.options.validateStatus = (status) {
    //   return status! < 500;
    // };

    return dio;
  }

  Dio get dio {
    return _dio;
  }

  get path;
}
