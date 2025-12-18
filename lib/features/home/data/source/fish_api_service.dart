import '../../../../core/constant/api_urls.dart';
import '../../../../core/networks/dio_client.dart';
import '../models/fish_model.dart';

abstract class FishApiService {
  Future<List<FishModel>> getFishList();
  Future<FishModel> getFishDetail(String id);
}

class FishApiServiceImpl implements FishApiService {
  final DioClient _dioClient;

  FishApiServiceImpl(this._dioClient);

  @override
  Future<List<FishModel>> getFishList() async {
    try {
      final response = await _dioClient.get(ApiUrls.fish);
      // Assuming response.data['data'] is the list based on provided JSON
      final List<dynamic> data = response.data['data'];
      return data.map((e) => FishModel.fromJson(e)).toList();
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<FishModel> getFishDetail(String id) async {
    try {
      final response = await _dioClient.get("${ApiUrls.fish}/$id");
      // Assuming response.data['data'] is the object for detail as well, typical pattern
      // Adjust if API returns object directly for detail
      return FishModel.fromJson(response.data['data']);
    } catch (e) {
      rethrow;
    }
  }
}
