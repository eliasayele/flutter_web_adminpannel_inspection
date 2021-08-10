import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:inspection_admin/models/Summary.dart';

import 'app_exception.dart';

class TokenValue {
  String token =
      "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiI3OTFjNDkzOS00ODQ4LTQxYjQtOWI4ZS04YTE4Njk0MmQzMWIiLCJwaG9uZSI6IjA5Mzk5OTU0NTQiLCJyb2xlIjoiR0FSQUdFLUFETUlOIiwiZ2FyYWdlX2lkIjoiY2IyYzBiMzUtYzZkNy00MGI0LTk5MmUtOGM4Yzg2OGIyZjUxIn0.12MpcvlGuIMTg6CuBN0AEMIT01HcsgFjOBSPsUeXMqo";
  String get getToken => token;
}

class ApiServices {
  String base_url =
      "https://138.68.163.236:7878/v1/summary?from=2021-06-01T08:57:35.827Z&to=2021-09-01T08:57:35.827Z";
  double uploadProgress = 0;
  Dio dio = Dio(BaseOptions(
    connectTimeout: 20000,
    receiveTimeout: 20000,
    headers: {
      'Authorization': 'Bearer ${TokenValue().getToken}',
      "Content-Type": "application/json",
    },
  ));

  ///search inspection by [temp by vin num] plate
  Future<Summary> loadSummary() async {
    late Response response;
    try {
      response = await dio.get(base_url);
      print("//////////////////");
      print(response.data);
      return Summary.fromJson(response.data);
    } on DioError catch (e) {
      debugPrint('this is load summary error: e' + e.toString());
      return throw ApiCallException.fromDioError(e);
    }
  }
}
