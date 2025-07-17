import 'package:dio/dio.dart';
import 'package:cookie_jar/cookie_jar.dart';
import 'package:dio_cookie_manager/dio_cookie_manager.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../utils/constants/api constants/api_constants.dart';

class DioHelper {
  static late Dio dio;
  static late CookieJar cookieJar;

  static void init() {
    dio = Dio(
      BaseOptions(
        baseUrl: baseUrl,
        connectTimeout: const Duration(seconds: 30),
        receiveTimeout: const Duration(seconds: 30),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
      ),
    );

    cookieJar = CookieJar();
    dio.interceptors.add(CookieManager(cookieJar));

    dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          final uri = Uri.parse(baseUrl);
          final cookies = await cookieJar.loadForRequest(uri);
          final csrfCookie = cookies.firstWhere(
            (c) => c.name.toLowerCase() == 'csrftoken',
            orElse: () => Cookie('csrftoken', ''),
          );

          options.headers['X-CSRFTOKEN'] = csrfCookie.value;

          return handler.next(options);
        },
        onError: (e, handler) {
          debugPrint("Error: ${e.message}");
          return handler.next(e);
        },
      ),
    );
  }

  static Future<void> addAuthHeader() async {
    final prefs = await SharedPreferences.getInstance();
    final csrfToken =
        "8mlFD0B35c9w70ebKooPYvfR6ci0sp6g1XGYlF7XVDG8Z5DrMjRPRSOMZmpTbNoi";
    //prefs.getString('csrftoken');

    if (csrfToken.isNotEmpty) {
      dio.options.headers['X-CSRFTOKEN'] = csrfToken;
      debugPrint('CSRF Token Set: $csrfToken');
    } else {
      debugPrint('No CSRF token found.');
    }

    debugPrint('Request Headers: ${dio.options.headers}');
  }

  static Future<Response> getAllData({
    required String url,
    Map<String, dynamic>? queryParameters,
  }) async {
    await addAuthHeader();
    if (!url.startsWith('http')) {
      url = '$baseUrl$url';
    }

    debugPrint('Requesting $url with headers: ${dio.options.headers}');
    return await dio.get(url, queryParameters: queryParameters);
  }

  static Future<Response> postData({
    required String url,
    required dynamic data,
  }) async {
    await addAuthHeader();
    debugPrint('Posting to $url with data: $data');
    return await dio.post(url, data: data);
  }

  static Future<Response> getSingleData({
    required String url,
    required String id,
  }) async {
    return await dio.get('$url/$id');
  }

  static Future<Response> deleteData({
    required String url,
    required String id,
  }) async {
    return await dio.delete('$url/$id');
  }
}
