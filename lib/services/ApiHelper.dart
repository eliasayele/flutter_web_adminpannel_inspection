// import 'package:dio/dio.dart';
//
// class ApiBaseHelper {
//   static final String url = 'http://139.59.191.34/api/';
//
//   static BaseOptions opts = BaseOptions(
//     baseUrl: url,
//     responseType: ResponseType.json,
//     connectTimeout: 30000,
//     receiveTimeout: 30000,
//   );
//
//   static Dio createDio() {
//     return Dio(opts);
//   }
//
//   static Dio addInterceptors(Dio dio) {
//     return dio
//       ..interceptors.add(
//         InterceptorsWrapper(
//             onRequest:
//                 (RequestOptions options, RequestInterceptorHandler handler) =>
//                     handler.next(requestInterceptor(options)),
//             onError: (DioError e, ErrorInterceptorHandler handler) async {
//               ///DioLogger.onError(TAG, error);
//               return handler.next(e.response!.data);
//             }),
//       );
//   }
//
//   static dynamic requestInterceptor(RequestOptions options) async {
//     //String token = locator<UserProvider>().getToken!;
//     String token = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiI3OTFjNDkzOS00ODQ4LTQxYjQtOWI4ZS04YTE4Njk0MmQzMWIiLCJwaG9uZSI6IjA5Mzk5OTU0NTQiLCJyb2xlIjoiR0FSQUdFLUFETUlOIiwiZ2FyYWdlX2lkIjoiY2IyYzBiMzUtYzZkNy00MGI0LTk5MmUtOGM4Yzg2OGIyZjUxIn0.12MpcvlGuIMTg6CuBN0AEMIT01HcsgFjOBSPsUeXMqo";
//
//     options.headers.addAll({"Authorization": "Bearer: $token"});
//     return options;
//   }
//
//   static final dio = createDio();
//
//   // static final baseAPI = addInterceptors(dio);
//
//   ///get the allowed in case we develop
//   Future<Response?> getHTTP(String url) async {
//     try {
//       Response response = await dio.get(url);
//       return response;
//     } on DioError catch (e) {
//       print("Get Http error happen check");
//       print(e.message);
//     }
//   }
//
//   Future<Response?> postHTTP(String url, dynamic data) async {
//     try {
//       Response response = await dio.post(url, data: data);
//       return response;
//     } on DioError catch (e) {
//       // Handle error
//       print("post HTTP error happen check");
//       print(e.message);
//     }
//   }
//
//   Future<Response?> putHTTP(String url, dynamic data) async {
//     try {
//       Response response = await dio.put(url, data: data);
//       return response;
//     } on DioError catch (e) {
//       print("put HTTP error happen check");
//       print(e.message);
//     }
//   }
//
//   Future<Response?> deleteHTTP(String url) async {
//     try {
//       Response response = await dio.delete(url);
//       return response;
//     } on DioError catch (e) {
//       // Handle error
//       print("delete HTTP error happen check");
//       print(e.message);
//     }
//   }
//
//   // // Multiple Files with Additional Data
//   // FormData formData = FormData.fromMap({
//   //
//   //   "files": [
//   //     await MultipartFile.fromFile("PATH", filename: "OPTIONAL"),
//   //     MultipartFile.fromFileSync("PATH", filename: "OPTIONAL")
//   //   ],
//   // });
// }
//
// // class ApiBaseHelper {
// //
// //   final String _baseUrl = "https://opentdb.com/api.php?amount=10";
// //
// //   Future<dynamic> get(String url) async {
// //     var responseJson;
// //     try {
// //       final response = await Dio().get(_baseUrl + url);
// //       responseJson = _returnResponse(response);
// //     } on SocketException {
// //       throw FetchDataException('No Internet connection');
// //     }
// //     return responseJson;
// //   }
// //
// //   dynamic _returnResponse(Dio().Response response) {
// //     switch (response.statusCode) {
// //       case 0:
// //         var responseJson = json.decode(response.body.toString());
// //         print(responseJson);
// //         return responseJson;
// //       case 400:
// //         throw BadRequestException(response.body.toString());
// //       case 401:
// //       case 403:
// //         throw UnauthorisedException(response.body.toString());
// //       case 500:
// //       default:
// //         throw FetchDataException(
// //             'Error occured while Communication with Server with StatusCode : ${response.statusCode}');
// //     }
// //
// //   }
