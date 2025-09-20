import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:possy_app/core/services/api_services/api_endpoints.dart';
 
class ApiServices {
  static final Dio _dio = Dio();
 
  /// GET request
  static Future<dynamic> getRequest({
    required String endpoints,
    Map<String, String>? headers,
  }) async {
    try {
      final response = await _dio.get(
        '${ApiEndpoints.baseUrl}/$endpoints',
        options: Options(headers: headers),
      );
      debugPrint("\nGET Request Successful: ${response.data}\n");
      return response.data;
    } on DioException catch (e) {
      debugPrint("\nGET Request Failed: ${e.response?.statusCode} - ${e.response?.data}\n");
      return null;
    } catch (error) {
      debugPrint("\nError in GET Request: $error\n");
      return null;
    }
  }
 
  /// POST request
  static Future<dynamic> postRequest({
    required String endpoints,
    required Map<String, dynamic> body,
    Map<String, String>? headers,
  }) async {
    try {
      final response = await _dio.post(
        '${ApiEndpoints.baseUrl}/$endpoints',
        data: body,
        options: Options(headers: headers ?? {"Content-Type": "application/json"}),
      );
      debugPrint("\nPOST Request Successful: ${response.data}\n");
      return response.data;
    } on DioException catch (e) {
      debugPrint("\nPOST Request Failed: ${e.response?.statusCode} - ${e.response?.data}\n");
      return null;
    } catch (error) {
      debugPrint("\nError in POST Request: $error\n");
      return null;
    }
  }
 
  /// PUT request
  static Future<dynamic> putRequest({
    required String endpoints,
    required Map<String, dynamic> body,
    Map<String, String>? headers,
  }) async {
    try {
      final response = await _dio.put(
        '${ApiEndpoints.baseUrl}/$endpoints',
        data: body,
        options: Options(headers: headers ?? {"Content-Type": "application/json"}),
      );
      debugPrint("\nPUT Request Successful: ${response.data}\n");
      return response.data;
    } on DioException catch (e) {
      debugPrint("\nPUT Request Failed: ${e.response?.statusCode} - ${e.response?.data}\n");
      return null;
    } catch (error) {
      debugPrint("\nError in PUT Request: $error\n");
      return null;
    }
  }
 
  /// PATCH request
  static Future<dynamic> patchRequest({
    required String endpoints,
    required FormData formData,
    Map<String, String>? headers,
  }) async {
    try {
      final response = await _dio.patch(
        '${ApiEndpoints.baseUrl}/$endpoints',
        data: formData,
        options: Options(
          headers: headers ?? {"Content-Type": "multipart/form-data"},
        ),
      );
 
      debugPrint("\n✅ PATCH Request Successful");
      debugPrint("Status: ${response.statusCode}");
      debugPrint("Data: ${response.data}");
 
      return response.data;
    } on DioException catch (e) {
      debugPrint("\n❌ PATCH Request Failed");
      debugPrint("Status: ${e.response?.statusCode}");
      debugPrint("Error Data: ${e.response?.data}");
      return null;
    } catch (error) {
      debugPrint("\n❌ Error in PATCH Request: $error\n");
      return null;
    }
  }
 
}