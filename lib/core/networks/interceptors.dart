import 'package:dio/dio.dart';
import 'package:logger/logger.dart';
import 'package:pui_bhasbi_mobile/common/bloc/auth/auth_cubit.dart';
import 'package:pui_bhasbi_mobile/core/services/service_locator.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// This interceptor is used to show request and response logs
class LoggerInterceptor extends Interceptor {
  Logger logger = Logger(
    printer: PrettyPrinter(methodCount: 0, colors: true, printEmojis: true),
  );

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    final options = err.requestOptions;
    final requestPath = '${options.baseUrl}${options.path}';
    logger.e('${options.method} request ==> $requestPath'); //Error log
    logger.d(
      'Error type: ${err.error} \n '
      'Error message: ${err.message}'
      'SERVER RESPONSE: ${err.response?.data}',
    ); //Debug log
    
    // Check for 401 or 403 status codes (Unauthorized/Forbidden)
    if (err.response?.statusCode == 401 || err.response?.statusCode == 403) {
      logger.w('Unauthorized/Forbidden request detected (${err.response?.statusCode}). Logging out user.');
      // Logout the user and redirect to login page
      sl<AuthStateCubit>().logout();
    } else {
      logger.w('An error occurred: ${err.message}');
    }
    
    handler.next(err); //Continue with the Error
  }

  @override
  Future<void> onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    // 1. Ambil SharedPreferences
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

    // 2. Cek apakah token ada. Support both 'token' and 'access_token' keys for compatibility.
    String? token;
    if (sharedPreferences.containsKey('auth_token')) {
      token = sharedPreferences.getString('auth_token');
    } else if (sharedPreferences.containsKey('token')) {
      token = sharedPreferences.getString('token');
    } else if (sharedPreferences.containsKey('access_token')) {
      token = sharedPreferences.getString('access_token');
    }

    if (token != null && token.isNotEmpty) {
      // 3. Tambahkan header Authorization jika token tersedia
      options.headers['Authorization'] = 'Bearer $token';
    }

    final requestPath = '${options.baseUrl}${options.path}';
    String fullPath = requestPath;
    if (options.queryParameters.isNotEmpty) {
      final qp = options.queryParameters.entries
          .map(
            (e) =>
                '${Uri.encodeQueryComponent(e.key)}=${Uri.encodeQueryComponent('${e.value}')}',
          )
          .join('&');
      fullPath = '$requestPath?$qp';
    }
    logger.i('${options.method} request ==> $fullPath');
    logger.d('Headers: ${options.headers}'); // Log headers to check token
    return super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    logger.d(
      'STATUSCODE: ${response.statusCode} \n '
      'STATUSMESSAGE: ${response.statusMessage} \n'
      'HEADERS: ${response.headers} \n'
      'Data: ${response.data}',
    ); // Debug log
    handler.next(response); // continue with the Response
  }
}
