import '../../../../core/resources/data_state.dart';
import '../entity/report_entity.dart';
import '../entity/report_request_entity.dart';

abstract class ReportRepository {
  Future<DataState<List<ReportEntity>>> getApprovedReports();
  Future<DataState<List<ReportEntity>>> getMyReports();
  Future<DataState<ReportEntity>> submitReport(ReportRequestEntity request);
}
