import 'package:active_ecommerce_flutter/app_config.dart';
import 'package:active_ecommerce_flutter/helpers/shared_value_helper.dart';
import 'package:active_ecommerce_flutter/helpers/system_config.dart';
import 'package:active_ecommerce_flutter/main.dart';
import 'package:dio/dio.dart';

class DioHelper {
  static late Dio? dio;

  static init() {
    dio = Dio(
      BaseOptions(
        baseUrl: AppConfig.BASE_URL,
      ),
    );
  }

  static Future<Response<dynamic>> get({
    required String url,
    Map<String, dynamic>? queryParameters,
    Object? data,
  }) async {
    // logger.d(app_language.$);
    // logger.d(SystemConfig.systemCurrency!.code!);
    // logger.d(SystemConfig.systemCurrency!.exchangeRate!);
    return await dio!.get(
      url,
      queryParameters: queryParameters,
      data: data,
      options: Options(
        headers: {
          "App-Language": app_language.$!,
          "Currency-Code": SystemConfig.systemCurrency!.code!,
          "Currency-Exchange-Rate": SystemConfig.systemCurrency!.exchangeRate!,
        },
      ),
    );
  }

  static Future<Response<dynamic>> post({
    required String url,
    Object? data,
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) async {
    logger.d(app_language.$);
    logger.d(SystemConfig.systemCurrency!.code!);
    logger.d(SystemConfig.systemCurrency!.exchangeRate!);
    return await dio!.post(
      url,
      data: data,
      options: options ??
          Options(
            headers: {
              "App-Language": app_language.$!,
              "Currency-Code": SystemConfig.systemCurrency!.code!,
              "Currency-Exchange-Rate":
                  SystemConfig.systemCurrency!.exchangeRate!,
            },
          ),
      queryParameters: queryParameters,
    );
  }

  static Future<Response<dynamic>> put({
    required String url,
    Object? data,
    Map<String, dynamic>? queryParameters,
  }) async {
    return await dio!.put(
      url,
      data: data,
      options: Options(
        headers: {
          "App-Language": app_language.$!,
          "Currency-Code": SystemConfig.systemCurrency!.code!,
          "Currency-Exchange-Rate": SystemConfig.systemCurrency!.exchangeRate!,
        },
      ),
      queryParameters: queryParameters,
    );
  }

  static Future<Response<dynamic>> delete({
    required String url,
    Object? data,
    Map<String, dynamic>? queryParameters,
  }) async {
    return await dio!.delete(
      url,
      data: data,
      options: Options(
        headers: {
          "App-Language": app_language.$!,
          "Currency-Code": SystemConfig.systemCurrency!.code!,
          "Currency-Exchange-Rate": SystemConfig.systemCurrency!.exchangeRate!,
        },
      ),
      queryParameters: queryParameters,
    );
  }
}
