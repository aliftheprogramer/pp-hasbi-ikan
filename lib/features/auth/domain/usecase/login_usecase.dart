import '../../../../core/resources/data_state.dart';
import '../../../../core/usecase/usecase.dart';
import '../entity/login_request_entity.dart';
import '../entity/login_response_entity.dart';
import '../repository/auth_repository.dart';

class LoginUseCase
    implements Usecase<DataState<LoginResponseEntity>, LoginRequestEntity> {
  final AuthRepository _authRepository;

  LoginUseCase(this._authRepository);

  @override
  Future<DataState<LoginResponseEntity>> call({LoginRequestEntity? param}) {
    return _authRepository.login(param!);
  }
}
