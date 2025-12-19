import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/resources/data_state.dart';
import '../../domain/usecase/get_approved_reports_usecase.dart';
import 'approved_reports_state.dart';

class ApprovedReportsCubit extends Cubit<ApprovedReportsState> {
  final GetApprovedReportsUseCase _getApprovedReportsUseCase;

  ApprovedReportsCubit(this._getApprovedReportsUseCase)
    : super(ApprovedReportsInitial());

  Future<void> getApprovedReports() async {
    emit(ApprovedReportsLoading());
    final result = await _getApprovedReportsUseCase();

    if (result is DataSuccess) {
      emit(ApprovedReportsSuccess(result.data ?? []));
    } else if (result is DataFailed) {
      emit(ApprovedReportsError(result.error?.message ?? "Terjadi kesalahan"));
    }
  }
}
