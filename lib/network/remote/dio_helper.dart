import 'package:dio/dio.dart';

class DioHelper {
  static late Dio dio;

  ///declare the baseUrl for the API and initialise the dio
  static init() {
    dio = Dio(
      BaseOptions(
        baseUrl: 'https://newsapi.org/',
        receiveDataWhenStatusError: true,
      ),
    );
  }

  ///get method from the API
  static Future<Response> getData({
    required String url,
    required Map<String, dynamic> query,
  }) async {
    return await dio.get(
      url,
      queryParameters: query,
    );
  }
}
