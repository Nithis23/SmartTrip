// import 'package:blissful_yoga/SharedPreferences/loginSuccessResponse.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:smartrip/SharedPreferences/loginSuccessStatus.dart';

final dioProvider = Provider<Dio>((ref) {
  // String baseUrl = 'http://192.168.1.30:8080/';
  String baseUrl =
      'http://103.174.10.244:8080/yoga-shala-api/'; //http://103.174.10.244:8080/yoga-shala-api/api/user-types
  final dio = Dio(
    BaseOptions(
      baseUrl: baseUrl,
      connectTimeout: const Duration(seconds: 20),
      receiveTimeout: const Duration(seconds: 20),
      headers: {'Content-Type': 'application/json'},
      validateStatus: (status) {
        // ✅ Treat all responses as valid, so Dio won't throw errors
        return status != null && status >= 200 && status < 600;
      },
    ),
  );

  // final sharedService = AppStorage();

  dio.interceptors.add(
    InterceptorsWrapper(
      onRequest: (options, handler) async {
        final token = AppStorage.getToken();

        if (token != null && token.isNotEmpty) {
          options.headers['Authorization'] = 'Bearer $token';
        }
        print("Print Token : $token");
        print('➡️ [REQUEST] ${options.method} ${options.uri}');
        options.headers.forEach((key, value) {
          print('Header: $key => $value');
        });
        print('➡️ Data Type: ${options.data.runtimeType}');
        print('➡️ Data: ${options.data}');
        if (options.data is FormData) {
          (options.data as FormData).fields.forEach((field) {
            print('Field: ${field.key} => ${field.value}');
          });
          (options.data as FormData).files.forEach((file) {
            print(
              'File field: ${file.key} => filename: ${file.value.filename}',
            );
          });
        }

        return handler.next(options);
      },
      onResponse: (response, handler) {
        print('✅ [RESPONSE] ${response.statusCode} - ${response.data}');
        return handler.next(response);
      },
      onError: (DioException e, handler) {
        print('❌ [ERROR] ${e.response?.statusCode} - ${e.response?.data}');
        print('❌ [ERROR] Response Headers: ${e.response?.headers}');
        print('❌ [ERROR] Request Data: ${e.requestOptions.data}');

        if (e.response?.statusCode == 401) {
          print('⚠️ Token expired or unauthorized');
        }

        return handler.next(e);
      },
    ),
  );

  return dio;
});
