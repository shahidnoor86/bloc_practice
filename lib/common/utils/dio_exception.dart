import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';

class DioExceptions implements Exception {
  late String message;

  DioExceptions.fromDioError(DioException dioError) {
    switch (dioError.type) {
      case DioExceptionType.cancel:
        message = "Request to API server was cancelled";
        break;
      case DioExceptionType.connectionTimeout:
        message = "Connection timeout with API server";
        break;
      case DioExceptionType.receiveTimeout:
        message = "Receive timeout in connection with API server";
        break;
      case DioExceptionType.badResponse:
        message = _handleError(
            dioError.response!.statusCode, dioError.response?.data);
        break;
      case DioExceptionType.sendTimeout:
        message = "Send timeout in connection with API server";
        break;
      case DioExceptionType.unknown:
        if (dioError.message!.contains("SocketException")) {
          message = "No internet connection";
          break;
        }
        message = "Unexpected error occurred";
        break;
      default:
        message = "Something went wrong";
        break;
    }
  }

  String _handleError(var statusCode, dynamic error) {
    debugPrint("statusCode: $statusCode, 'error:: $error");
    switch (statusCode) {
      case 400:
        return "Bad request";
      case 401:
        return "Unauthorized";
      case 403:
        final result = json.decode(error.toString());
        return result['message'];
      //return 'Forbidden';
      case 404:
        final result = json.decode(error.toString());
        return result['message'];
      //return error['message'];
      case 500:
        return "Internal server error";
      case 502:
        return "Bad gateway";
      default:
        return "Oops something went wrong";
    }
  }

  @override
  String toString() => message;
}
