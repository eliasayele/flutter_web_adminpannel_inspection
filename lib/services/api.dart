import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:inspection_admin/controllers/FilterNotifieer.dart';
import 'package:inspection_admin/models/CompletedInspections.dart';
import 'package:inspection_admin/models/Summary.dart';

import '../locator.dart';
import 'app_exception.dart';

class TokenValue {
  String token =
      "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiI3OTFjNDkzOS00ODQ4LTQxYjQtOWI4ZS04YTE4Njk0MmQzMWIiLCJwaG9uZSI6IjA5Mzk5OTU0NTQiLCJyb2xlIjoiR0FSQUdFLUFETUlOIiwiZ2FyYWdlX2lkIjoiY2IyYzBiMzUtYzZkNy00MGI0LTk5MmUtOGM4Yzg2OGIyZjUxIn0.12MpcvlGuIMTg6CuBN0AEMIT01HcsgFjOBSPsUeXMqo";
  String get getToken => token;
}

class ApiServices {
  // var from = locator<FilterNotifier>().from;
  // var to = locator<FilterNotifier>().to;
  String fetch_summary =
      "https://138.68.163.236:7878/v1/summary?from=${locator<FilterNotifier>().from}&to=${locator<FilterNotifier>().to}";

  String fetch_inspections = "https://138.68.163.236:7878/v1/inspections?";
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
      response = await dio.get(fetch_summary);
      print("//////////////////");
      print(response.data);
      return Summary.fromJson(response.data);
    } on DioError catch (e) {
      debugPrint('this is load summary error: e' + e.toString());
      return throw ApiCallException.fromDioError(e);
    }
  }

  Future<CompletedInspections> fetchInspections(pageNum) async {
    late Response response;
    try {
      //page=1&per_page=10&sort=DESC
      response = await dio
          .get(fetch_inspections + "page=${pageNum}&per_page=100&sort=DESC");
      // print("//////////////////");
      // print(response.data);
      return CompletedInspections.fromJson(response.data);
    } on DioError catch (e) {
      debugPrint('this is load summary error: e' + e.toString());
      return throw ApiCallException.fromDioError(e);
    }
  }
}
