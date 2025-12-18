import '../../../../core/constant/api_urls.dart';
import '../../../../core/networks/dio_client.dart';
import '../models/login_request.dart';
import '../models/login_response.dart';
import '../models/register_request.dart';
import '../models/register_response.dart';

abstract class AuthApiService {
  Future<LoginResponse> login(LoginRequest request);
  Future<RegisterResponse> register(RegisterRequest request);
}

class AuthApiServiceImpl implements AuthApiService {
  final DioClient _dioClient;

  AuthApiServiceImpl(this._dioClient);

  @override
  Future<LoginResponse> login(LoginRequest request) async {
    try {
      final response = await _dioClient.post(
        ApiUrls.login,
        data: request.toJson(),
      );
      return LoginResponse.fromJson(response.data);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<RegisterResponse> register(RegisterRequest request) async {
    try {
      final response = await _dioClient.post(
        ApiUrls.register,
        data: request.toJson(),
      );
      return RegisterResponse.fromJson(response.data);
    } catch (e) {
      rethrow;
    }
  }
}
