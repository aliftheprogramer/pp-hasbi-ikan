import 'package:dio/dio.dart';
import '../../../../core/constant/api_urls.dart';
import '../../../../core/networks/dio_client.dart';
import '../../domain/entity/report_request_entity.dart';
import '../models/report_model.dart';

abstract class ReportApiService {
  Future<List<ReportModel>> getApprovedReports();
  Future<ReportModel> submitReport(ReportRequestEntity request);
}

class ReportApiServiceImpl implements ReportApiService {
  final DioClient _dioClient;

  ReportApiServiceImpl(this._dioClient);

  @override
  Future<List<ReportModel>> getApprovedReports() async {
    try {
      final response = await _dioClient.get(ApiUrls.reportsApproved);
      if (response.data['success'] == true && response.data['data'] != null) {
        final List data = response.data['data'];
        return data.map((e) => ReportModel.fromJson(e)).toList();
      }
      return [];
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<ReportModel> submitReport(ReportRequestEntity request) async {
    try {
      final formData = FormData.fromMap({
        'description': request.description,
        'latitude': request.latitude,
        'longitude': request.longitude,
        if (request.addressText != null) 'addressText': request.addressText,
        if (request.fishReferenceId != null)
          'fishReferenceId': request.fishReferenceId,
        'photo': await MultipartFile.fromFile(request.photo.path),
      });

      final response = await _dioClient.post(ApiUrls.reports, data: formData);

      if (response.data['success'] == true && response.data['data'] != null) {
        return ReportModel.fromJson(response.data['data']);
      }
      throw DioException(
        requestOptions: RequestOptions(path: ApiUrls.reports),
        error: "Failed to submit report",
      );
    } catch (e) {
      rethrow;
    }
  }
}
