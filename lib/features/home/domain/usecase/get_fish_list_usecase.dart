import '../../../../core/resources/data_state.dart';
import '../../../../core/usecase/usecase.dart';
import '../entity/fish_entity.dart';
import '../repository/fish_repository.dart';

class GetFishListUseCase implements Usecase<DataState<List<FishEntity>>, void> {
  final FishRepository _fishRepository;

  GetFishListUseCase(this._fishRepository);

  @override
  Future<DataState<List<FishEntity>>> call({void param}) {
    return _fishRepository.getFishList();
  }
}
