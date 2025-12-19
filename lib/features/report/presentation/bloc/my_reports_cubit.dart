import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/resources/data_state.dart';
import '../../domain/usecase/get_my_reports_usecase.dart';
import 'my_reports_state.dart';

class MyReportsCubit extends Cubit<MyReportsState> {
  final GetMyReportsUseCase _getMyReportsUseCase;

  MyReportsCubit(this._getMyReportsUseCase) : super(MyReportsInitial());

  Future<void> getMyReports() async {
    emit(MyReportsLoading());
    final result = await _getMyReportsUseCase();

    if (result is DataSuccess) {
      emit(MyReportsSuccess(result.data ?? []));
    } else if (result is DataFailed) {
      emit(MyReportsError(result.error?.message ?? "Terjadi kesalahan"));
    }
  }
}
