import '../../../../core/constant/api_urls.dart';
import '../../../../core/networks/dio_client.dart';
import '../models/login_request.dart';
import '../models/login_response.dart';
import '../models/register_request.dart';
import '../models/register_response.dart';
import '../models/user_model.dart';

abstract class AuthApiService {
  Future<LoginResponse> login(LoginRequest request);
  Future<RegisterResponse> register(RegisterRequest request);
  Future<UserModel> getProfile();
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

  @override
  Future<UserModel> getProfile() async {
    try {
      final response = await _dioClient.get(ApiUrls.profile);
      if (response.data['success'] == true && response.data['data'] != null) {
        return UserModel.fromJson(response.data['data']);
      }
      throw Exception("Failed to load profile");
    } catch (e) {
      rethrow;
    }
  }
}
