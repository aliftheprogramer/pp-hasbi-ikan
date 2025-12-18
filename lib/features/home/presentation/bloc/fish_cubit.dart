import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/resources/data_state.dart';
import '../../domain/usecase/get_fish_list_usecase.dart';
import '../../domain/usecase/get_fish_detail_usecase.dart';
import 'fish_state.dart';

class FishCubit extends Cubit<FishState> {
  final GetFishListUseCase _getFishListUseCase;
  final GetFishDetailUseCase _getFishDetailUseCase;

  FishCubit(this._getFishListUseCase, this._getFishDetailUseCase)
    : super(FishInitial());

  Future<void> getFishList() async {
    emit(FishLoading());
    final dataState = await _getFishListUseCase();
    if (dataState is DataSuccess && dataState.data != null) {
      emit(FishLoaded(dataState.data!));
    } else if (dataState is DataFailed) {
      emit(FishError(dataState.error?.message ?? "Failed to fetch fish list"));
    }
  }

  Future<void> getFishDetail(String id) async {
    emit(FishLoading());
    final dataState = await _getFishDetailUseCase(param: id);
    if (dataState is DataSuccess && dataState.data != null) {
      emit(FishDetailLoaded(dataState.data!));
    } else if (dataState is DataFailed) {
      emit(
        FishError(dataState.error?.message ?? "Failed to fetch fish detail"),
      );
    }
  }
}
