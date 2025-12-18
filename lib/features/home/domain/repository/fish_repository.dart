import '../../../../core/resources/data_state.dart';
import '../entity/fish_entity.dart';

abstract class FishRepository {
  Future<DataState<List<FishEntity>>> getFishList();
  Future<DataState<FishEntity>> getFishDetail(String id);
}
