import '../../../../core/usecase/usecase.dart';
import '../entity/user_entity.dart';
import '../repository/auth_repository.dart';

class GetLocalUserUseCase implements Usecase<UserEntity?, void> {
  final AuthRepository _authRepository;

  GetLocalUserUseCase(this._authRepository);

  @override
  Future<UserEntity?> call({void param}) {
    return _authRepository.getUser();
  }
}
