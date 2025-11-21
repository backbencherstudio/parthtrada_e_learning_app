import 'package:dio/dio.dart';
import 'package:e_learning_app/core/services/api_services/api_end_points.dart';

import '../../repository/login_preferences.dart';


class Network {
  static final Network _instance = Network._internal();
  factory Network() => _instance;
  late Dio dio;

  Network._internal() {
    BaseOptions options = BaseOptions(
      baseUrl: ApiEndPoints.baseUrl,
      connectTimeout: const Duration(seconds: 60),
      receiveTimeout: const Duration(seconds: 60),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
    );

    dio = Dio(options);

    dio.interceptors.add(InterceptorsWrapper(
      onRequest: (options, handler) async {
        final token = await LoginPreferences().loadAuthToken();
        print('Injected Token: $token');
        if (token != null) {
          options.headers['Authorization'] = 'Bearer $token';
        }
        return handler.next(options);
      },
    ));

    // For debug logging
    dio.interceptors.add(LogInterceptor(
      responseBody: true,
      requestBody: true,
    ));
  }

}