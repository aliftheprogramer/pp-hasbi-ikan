import 'package:dio/dio.dart';
import '../../../../core/resources/data_state.dart';
import '../../domain/entity/report_entity.dart';
import '../../domain/entity/report_request_entity.dart';
import '../../domain/repository/report_repository.dart';
import '../source/report_api_service.dart';

class ReportRepositoryImpl implements ReportRepository {
  final ReportApiService _apiService;

  ReportRepositoryImpl(this._apiService);

  @override
  Future<DataState<List<ReportEntity>>> getApprovedReports() async {
    try {
      final result = await _apiService.getApprovedReports();
      return DataSuccess(data: result);
    } on DioException catch (e) {
      return DataFailed(e);
    }
  }

  @override
  Future<DataState<List<ReportEntity>>> getMyReports() async {
    try {
      final result = await _apiService.getMyReports();
      return DataSuccess(data: result);
    } on DioException catch (e) {
      return DataFailed(e);
    }
  }

  @override
  Future<DataState<ReportEntity>> submitReport(
    ReportRequestEntity request,
  ) async {
    try {
      final result = await _apiService.submitReport(request);
      return DataSuccess(data: result);
    } on DioException catch (e) {
      return DataFailed(e);
    }
  }
}
