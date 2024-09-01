import 'dart:convert';

import 'package:bloc_practice/common/utils/app_constants.dart';
import 'package:bloc_practice/common/utils/dio_wrapper.dart';
import 'package:bloc_practice/data/models/product_model.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class ProductRepository {
  Future<ProductResponse> getProductList() async {
    final dio = await DioWrapper().getDio();
    Response response = await dio.get(
      '${AppConstants.authApiBaseUrl}/${AppConstants.getProductList}',
    );
    final result =
    ProductResponse.fromJson(json.decode(response.toString()));

    /*if (result.statusCode != 200) {
      throw Exception();
    }*/
    debugPrint("SHAHID @@@@@@ Response Data ${response.data}");
    return result;
  }
}
