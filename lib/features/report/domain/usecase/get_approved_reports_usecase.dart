import '../../../../core/resources/data_state.dart';
import '../../../../core/usecase/usecase.dart';
import '../entity/report_entity.dart';
import '../repository/report_repository.dart';

class GetApprovedReportsUseCase
    implements Usecase<DataState<List<ReportEntity>>, void> {
  final ReportRepository _repository;

  GetApprovedReportsUseCase(this._repository);

  @override
  Future<DataState<List<ReportEntity>>> call({void param}) {
    return _repository.getApprovedReports();
  }
}
