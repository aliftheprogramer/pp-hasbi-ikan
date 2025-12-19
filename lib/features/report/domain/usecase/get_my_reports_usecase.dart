import '../../../../core/resources/data_state.dart';
import '../../../../core/usecase/usecase.dart';
import '../entity/report_entity.dart';
import '../repository/report_repository.dart';

class GetMyReportsUseCase
    implements Usecase<DataState<List<ReportEntity>>, void> {
  final ReportRepository _repository;

  GetMyReportsUseCase(this._repository);

  @override
  Future<DataState<List<ReportEntity>>> call({void param}) {
    return _repository.getMyReports();
  }
}
