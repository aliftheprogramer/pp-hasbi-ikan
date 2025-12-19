import '../../../../core/resources/data_state.dart';
import '../../../../core/usecase/usecase.dart';
import '../entity/user_entity.dart';
import '../repository/auth_repository.dart';

class GetProfileUseCase implements Usecase<DataState<UserEntity>, void> {
  final AuthRepository _repository;

  GetProfileUseCase(this._repository);

  @override
  Future<DataState<UserEntity>> call({void param}) {
    return _repository.getProfile();
  }
}
