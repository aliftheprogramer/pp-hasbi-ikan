import 'package:dio/dio.dart';
import '../../../../core/resources/data_state.dart';
import '../../domain/entity/login_request_entity.dart';
import '../../domain/entity/login_response_entity.dart';
import '../../domain/entity/register_request_entity.dart';
import '../../domain/entity/register_response_entity.dart';
import '../../domain/repository/auth_repository.dart';
import '../models/login_request.dart';
import '../models/register_request.dart';
import '../source/auth_api_service.dart';
import '../source/auth_local_services.dart';
import '../models/user_model.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthApiService _apiService;
  final AuthLocalService _localService;

  AuthRepositoryImpl(this._apiService, this._localService);

  @override
  Future<DataState<LoginResponseEntity>> login(
    LoginRequestEntity params,
  ) async {
    try {
      final request = LoginRequest(
        email: params.email,
        password: params.password,
      );
      final response = await _apiService.login(request);

      if (response.success == true && response.token != null) {
        await _localService.saveToken(response.token!);
        if (response.user?.id != null) {
          await _localService.saveUserId(response.user!.id!);
        }
        if (response.user != null) {
          await _localService.saveUser(UserModel.fromEntity(response.user!));
        }
        return DataSuccess(data: response);
      } else {
        return DataFailed(
          DioException(
            requestOptions: RequestOptions(path: ''),
            error: "Login failed: Success flag is false or token missing",
            type: DioExceptionType.badResponse,
          ),
        );
      }
    } on DioException catch (e) {
      return DataFailed(e);
    }
  }

  @override
  Future<DataState<RegisterResponseEntity>> register(
    RegisterRequestEntity params,
  ) async {
    try {
      final request = RegisterRequest(
        email: params.email,
        password: params.password,
        name: params.name,
        role: params.role,
      );
      final response = await _apiService.register(request);

      if (response.success == true && response.token != null) {
        await _localService.saveToken(response.token!);
        if (response.user?.id != null) {
          await _localService.saveUserId(response.user!.id!);
        }
        if (response.user != null) {
          await _localService.saveUser(UserModel.fromEntity(response.user!));
        }
        return DataSuccess(data: response);
      } else if (response.success == true) {
        return DataSuccess(data: response);
      } else {
        return DataFailed(
          DioException(
            requestOptions: RequestOptions(path: ''),
            error: "Register failed: Success flag is false",
            type: DioExceptionType.badResponse,
          ),
        );
      }
    } on DioException catch (e) {
      return DataFailed(e);
    }
  }

  @override
  Future<bool> isLoggedIn() async {
    final token = await _localService.getToken();
    return token != null;
  }
}
