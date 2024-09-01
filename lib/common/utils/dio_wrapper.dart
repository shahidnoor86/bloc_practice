import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

bool isRedirecting = false;

class DioWrapper {
  static DioWrapper? _instance;

  static Dio? _dio;

  // Flag to track redirection state

  factory DioWrapper() {
    return _instance == null ? DioWrapper._internal() : _instance!;
  }

  DioWrapper._internal() {
    _instance = this;
  }

  Future<Dio> getDio() async {
    if (_dio == null) {
      final headers = {
        'Accept': 'application/json',
        'X-platform': Platform.operatingSystem,
      };

      _dio = Dio(
        BaseOptions(
          connectTimeout: const Duration(milliseconds: 600000),
          receiveTimeout: const Duration(milliseconds: 600000),
          headers: headers,
        ),
      );

      _dio?.interceptors.add(InterceptorsWrapper(
        /*onRequest: (options, handler) {
          final authToken = UserRepository().getApiAccessToken();
          if (authToken != null) {
            options.headers['X-authorization'] = authToken;
          }

          return handler.next(options);
        },*/
        onResponse: (response, handler) {
          handler.next(response);
        },
        onError: (error, handler) async {
          debugPrint('@@@@@@@@@@@@@@@@@@@@ onError ${error.response}');
          if (error.response != null && error.response!.statusCode == 401) {
            debugPrint('############# dio error 401');
            debugPrint('isRedirecting---> ${isRedirecting}');

            if (!isRedirecting) {
              isRedirecting = true;
            }
          } else {
            debugPrint('####-DioWrapper## ${error.response}');
            handler.reject(error);
          }
        },
      ));

      _dio?.interceptors.add(LogInterceptor(
        responseBody: true,
        requestBody: true,
      ));
    }

    return _dio!;
  }

  Future<Response<dynamic>> _retry(RequestOptions requestOptions) async {
    debugPrint('############# Retry last failed request');
    final options = Options(
      method: requestOptions.method,
      headers: requestOptions.headers,
    );
    return _dio!.request<dynamic>(
      requestOptions.path,
      data: requestOptions.data,
      queryParameters: requestOptions.queryParameters,
      options: options,
    );
  }
}
