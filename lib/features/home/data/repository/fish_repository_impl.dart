import 'package:dio/dio.dart';
import '../../../../core/resources/data_state.dart';
import '../../domain/entity/fish_entity.dart';
import '../../domain/repository/fish_repository.dart';
import '../source/fish_api_service.dart';

class FishRepositoryImpl implements FishRepository {
  final FishApiService _fishApiService;

  FishRepositoryImpl(this._fishApiService);

  @override
  Future<DataState<List<FishEntity>>> getFishList() async {
    try {
      final fishList = await _fishApiService.getFishList();
      return DataSuccess(data: fishList);
    } on DioException catch (e) {
      return DataFailed(e);
    }
  }

  @override
  Future<DataState<FishEntity>> getFishDetail(String id) async {
    try {
      final fish = await _fishApiService.getFishDetail(id);
      return DataSuccess(data: fish);
    } on DioException catch (e) {
      return DataFailed(e);
    }
  }
}
