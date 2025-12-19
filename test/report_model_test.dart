import 'package:flutter_test/flutter_test.dart';
import 'package:pui_bhasbi_mobile/features/report/data/models/report_model.dart';
import 'package:pui_bhasbi_mobile/features/report/domain/entity/report_entity.dart';

void main() {
  group('ReportModel', () {
    test('should correctly parse nested _doc structure from API', () {
      // JSON structure taken from the user's logs
      final Map<String, dynamic> json = {
        "success": true,
        "data": [
          {
            "\$__": {
              "activePaths": {
                "paths": {
                  // ... omitted for brevity
                },
              },
            },
            "\$isNew": false,
            "_doc": {
              "_id": "6945b077fe2388c8ec5801f4",
              "userId": "6945af4afe2388c8ec5801d3",
              "fishReferenceId": null,
              "description": "jdjsjsjs",
              "photoUrl":
                  "https://res.cloudinary.com/dp4cmgw8n/image/upload/v1766174839/bhasbi-reports/ufm1x7o0fvg5vl7vvodk.jpg",
              "latitude": -7.7424296,
              "longitude": 110.3739649,
              "addressText":
                  "Jl. Palagan Tentara Pelajar No.54c, Sariharjo, Kecamatan Ngaglik, Kabupaten Sleman, Daerah Istimewa Yogyakarta",
              "status": "PENDING",
              "created_at": "2025-12-19T20:07:19.665Z",
              "updated_at": "2025-12-19T20:07:19",
            },
          },
        ],
      };

      final dataList = json['data'] as List;
      final report = ReportModel.fromJson(dataList[0]);

      expect(report.id, "6945b077fe2388c8ec5801f4");
      expect(report.status, "PENDING"); // This is the main fix we need
      expect(report.description, "jdjsjsjs");
      expect(report.latitude, -7.7424296);
      expect(report.createdAt, "2025-12-19T20:07:19.665Z");
    });

    test('should correctly parse standard clean JSON (fallback)', () {
      final Map<String, dynamic> json = {
        "id": "123",
        "status": "APPROVED",
        "description": "Clean JSON",
        "latitude": 1.0,
        "longitude": 1.0,
        "createdAt": "2025-01-01",
      };

      final report = ReportModel.fromJson(json);
      expect(report.id, "123");
      expect(report.status, "APPROVED");
      expect(report.description, "Clean JSON");
    });
  });
}
