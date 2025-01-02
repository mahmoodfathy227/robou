import 'package:dio/dio.dart';
import 'package:get/get.dart' hide FormData hide Response;
import 'package:get/get_core/src/get_main.dart';
import 'package:robua/app/data/constants.dart';

import '../../modules/home/views/home_view.dart';

class ApiService {
  final Dio _dio;

  ApiService({Dio? dio})
      : _dio = dio ?? Dio(BaseOptions(
    baseUrl: 'https://robuashaqraa.com/api',
    headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    'Authorization' : 'Bearer ${AppConstants.userToken.toString()}'

    },

    connectTimeout: Duration(milliseconds: 5000),
    receiveTimeout: Duration(milliseconds: 3000),
  )) {
    _dio.interceptors.add(InterceptorsWrapper(
      onRequest: (options, handler) {
        // Add any headers or modifications here
        return handler.next(options);
      },
      onResponse: (response, handler) {
        // Handle responses here
        return handler.next(response);
      },
      onError: (DioError e, handler) {
        // Handle errors here
        // Log error
        print('Error: ${e.response?.statusCode} ${e.message}');
        // Handle specific errors like 401 Unauthorized
        if (e.response?.statusCode == 401) {
          // Handle unauthorized
        }
        return handler.next(e);
      },
    ));
  }

  Future<Response> getRequest(String path, {Map<String, dynamic>? queryParameters}) async {
    try {
      final response = await _dio.request(
          path,
          queryParameters: queryParameters,
        options: Options(
          method: 'GET',
     headers: {
       'Content-Type': 'application/json',
       'Accept': 'application/json',
       'Authorization' : 'Bearer ${AppConstants.userToken.toString()}'
     },

        ),

      );
      return response;
    } on DioError catch (e) {
      // Handle DioError here
      if(e.response!.statusCode == 401){
        Get.snackbar("خطأ", 'انتهت صلاحية الجلسة');
        AppConstants.userToken = null;
        Get.offAll(() => HomeView());
      }

      throw Exception('Failed to load data: ${e.message}');
    }
  }


  Future<Response> postMethod({
    required String endpoint,
    required Map<String, dynamic> data,

  }) async {


    try {

      var formData = FormData.fromMap(data);
      var response = await _dio.request(
        'https://robuashaqraa.com/api$endpoint',
        options: Options(
          method: 'POST',
            headers: {
              'Content-Type': 'application/json',
              'Accept': 'application/json',
              'Authorization' : 'Bearer ${AppConstants.userToken.toString()}'
            },
          validateStatus: (status) {
            return status! < 500; // Accept responses with status codes < 500
          },
        ),
        data: formData,
      );

   return response;
    } on DioException catch (  e) {
      if(e.response == null){
        Get.snackbar("خطأ",  e.message! ,snackPosition: SnackPosition.BOTTOM,

        );

      }
      if(e.response!.data['msg'] ==null){
        Get.snackbar("خطأ",
          e.response!.data['msg'] + e.message!?? "",
          snackPosition: SnackPosition.BOTTOM,



        );
      } else {
        Get.snackbar("خطأ", e.response!.data['msg'],
          snackPosition: SnackPosition.BOTTOM,

        );
        print("error in your api sending  ${e.stackTrace} + ${e.response.toString()} + ${e.message}");
      }

      // Handle DioError here
      // throw Exception('Failed to post data: ${ e.response.toString()
      //
      //    }');

      throw Exception('Failed to post data: ${e.stackTrace} + ${e.response.toString()} + ${e.message}');
      // throw e.response.toString();
    }
  }


//   Future<Response> postRequest(String path, {Map<String, dynamic>? data}) async {
//     try {
//       final response = await _dio.post(path, data: data);
//       return response;
//     } on DioError catch (  e) {
//       // Handle DioError here
//       // throw Exception('Failed to post data: ${ e.response.toString()
//       //
//       //    }');
// throw Exception('Failed to post data: ${e.stackTrace} + ${e.response.toString()} + ${e.message}');
//       // throw e.response.toString();
//     }
//   }
}
