import '../../../../core/resources/data_state.dart';
import '../../../../core/usecase/usecase.dart';
import '../entity/report_entity.dart';
import '../entity/report_request_entity.dart';
import '../repository/report_repository.dart';

class SubmitReportUseCase
    implements Usecase<DataState<ReportEntity>, ReportRequestEntity> {
  final ReportRepository _repository;

  SubmitReportUseCase(this._repository);

  @override
  Future<DataState<ReportEntity>> call({ReportRequestEntity? param}) {
    if (param == null) {
      throw ArgumentError("ReportRequestEntity cannot be null");
    }
    return _repository.submitReport(param);
  }
}
