import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/resources/data_state.dart';
import '../../domain/usecase/get_fish_detail_usecase.dart';
import 'fish_detail_state.dart';

class FishDetailCubit extends Cubit<FishDetailState> {
  final GetFishDetailUseCase _getFishDetailUseCase;

  FishDetailCubit(this._getFishDetailUseCase) : super(FishDetailInitial());

  Future<void> getFishDetail(String id) async {
    emit(FishDetailLoading());
    final dataState = await _getFishDetailUseCase(param: id);
    if (dataState is DataSuccess && dataState.data != null) {
      emit(FishDetailSuccess(dataState.data!));
    } else if (dataState is DataFailed) {
      emit(
        FishDetailFailure(dataState.error?.message ?? "Failed to fetch detail"),
      );
    }
  }
}
