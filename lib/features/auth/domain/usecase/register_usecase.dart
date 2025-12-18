import '../../../../core/resources/data_state.dart';
import '../../../../core/usecase/usecase.dart';
import '../entity/register_request_entity.dart';
import '../entity/register_response_entity.dart';
import '../repository/auth_repository.dart';

class RegisterUseCase
    implements
        Usecase<DataState<RegisterResponseEntity>, RegisterRequestEntity> {
  final AuthRepository _authRepository;

  RegisterUseCase(this._authRepository);

  @override
  Future<DataState<RegisterResponseEntity>> call({
    RegisterRequestEntity? param,
  }) {
    return _authRepository.register(param!);
  }
}
