import '../../../../core/resources/data_state.dart';
import '../../../../core/usecase/usecase.dart';
import '../entity/fish_entity.dart';
import '../repository/fish_repository.dart';

class GetFishDetailUseCase implements Usecase<DataState<FishEntity>, String> {
  final FishRepository _fishRepository;

  GetFishDetailUseCase(this._fishRepository);

  @override
  Future<DataState<FishEntity>> call({String? param}) {
    if (param == null) {
      // Handle missing parameter case appropriately, maybe throw exception or return error state
      return _fishRepository.getFishDetail("");
    }
    return _fishRepository.getFishDetail(param);
  }
}
