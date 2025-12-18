import '../../../../core/resources/data_state.dart';
import '../entity/login_request_entity.dart';
import '../entity/login_response_entity.dart';
import '../entity/register_request_entity.dart';
import '../entity/register_response_entity.dart';
import '../entity/user_entity.dart';

abstract class AuthRepository {
  Future<DataState<LoginResponseEntity>> login(LoginRequestEntity params);
  Future<DataState<RegisterResponseEntity>> register(
    RegisterRequestEntity params,
  );
  Future<bool> isLoggedIn();
  Future<UserEntity?> getUser();
  Future<void> logout();
}
