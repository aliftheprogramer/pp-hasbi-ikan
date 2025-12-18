import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/resources/data_state.dart';
import '../../domain/entity/report_request_entity.dart';
import '../../domain/usecase/get_approved_reports_usecase.dart';
import '../../domain/usecase/submit_report_usecase.dart';
import 'report_state.dart';

class ReportCubit extends Cubit<ReportState> {
  final GetApprovedReportsUseCase _getApprovedReportsUseCase;
  final SubmitReportUseCase _submitReportUseCase;

  ReportCubit(this._getApprovedReportsUseCase, this._submitReportUseCase)
    : super(ReportInitial());

  Future<void> getApprovedReports() async {
    emit(ReportLoading());
    final result = await _getApprovedReportsUseCase();
    if (result is DataSuccess && result.data != null) {
      emit(ReportLoaded(result.data!));
    } else if (result is DataFailed) {
      emit(ReportError(result.error?.message ?? "Failed to fetch reports"));
    }
  }

  Future<void> submitReport(ReportRequestEntity request) async {
    emit(ReportLoading());
    final result = await _submitReportUseCase(param: request);
    if (result is DataSuccess && result.data != null) {
      emit(ReportSubmissionSuccess(result.data!));
      // Refresh list after success
      await getApprovedReports();
    } else if (result is DataFailed) {
      emit(ReportError(result.error?.message ?? "Failed to submit report"));
    }
  }
}
