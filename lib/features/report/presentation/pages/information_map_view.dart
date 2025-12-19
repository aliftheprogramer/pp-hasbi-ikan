import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:geolocator/geolocator.dart';
import 'package:pui_bhasbi_mobile/features/report/domain/entity/report_entity.dart';
import 'package:pui_bhasbi_mobile/features/report/presentation/pages/report_detail_page.dart';
import '../../../../common/theme/app_theme.dart';

class InformationMapView extends StatefulWidget {
  final List<ReportEntity> reports;

  const InformationMapView({super.key, required this.reports});

  @override
  State<InformationMapView> createState() => _InformationMapViewState();
}

class _InformationMapViewState extends State<InformationMapView> {
  late final MapController _mapController;

  @override
  void initState() {
    super.initState();
    _mapController = MapController();
  }

  @override
  void dispose() {
    _mapController.dispose();
    super.dispose();
  }

  Future<void> _moveToCurrentLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Layanan lokasi tidak aktif.')),
      );
      return;
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        if (!mounted) return;
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(const SnackBar(content: Text('Izin lokasi ditolak.')));
        return;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Izin lokasi ditolak secara permanen.')),
      );
      return;
    }

    try {
      final position = await Geolocator.getCurrentPosition();
      _mapController.move(LatLng(position.latitude, position.longitude), 15.0);
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Gagal mendapatkan lokasi: $e')));
    }
  }

  @override
  Widget build(BuildContext context) {
    // Default center if no reports
    final initialCenter =
        widget.reports.isNotEmpty &&
            widget.reports.first.latitude != null &&
            widget.reports.first.longitude != null
        ? LatLng(
            widget.reports.first.latitude!,
            widget.reports.first.longitude!,
          )
        : const LatLng(-7.7956, 110.3695); // Yogyakarta default

    return Stack(
      children: [
        FlutterMap(
          mapController: _mapController,
          options: MapOptions(initialCenter: initialCenter, initialZoom: 13.0),
          children: [
            TileLayer(
              urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
              userAgentPackageName: 'com.bhasbi.app',
            ),
            MarkerLayer(
              markers: widget.reports
                  .where(
                    (report) =>
                        report.latitude != null && report.longitude != null,
                  )
                  .map((report) {
                    return Marker(
                      point: LatLng(report.latitude!, report.longitude!),
                      width: 40,
                      height: 40,
                      child: GestureDetector(
                        onTap: () => _showReportDetail(context, report),
                        child: const Icon(
                          Icons.location_on,
                          color: Colors.red,
                          size: 40,
                        ),
                      ),
                    );
                  })
                  .toList(),
            ),
          ],
        ),
        Positioned(
          bottom: 24,
          right: 24,
          child: FloatingActionButton(
            backgroundColor: AppTheme.primaryColor,
            heroTag: "my_location_btn",
            onPressed: _moveToCurrentLocation,
            child: const Icon(Icons.my_location, color: Colors.white),
          ),
        ),
      ],
    );
  }

  void _showReportDetail(BuildContext context, ReportEntity report) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (context) {
        return Container(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  CircleAvatar(
                    radius: 20,
                    backgroundImage: report.user?.avatarUrl != null
                        ? NetworkImage(report.user!.avatarUrl!)
                        : null,
                    child: report.user?.avatarUrl == null
                        ? const Icon(Icons.person)
                        : null,
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          report.user?.name ?? 'Pengguna Tidak Dikenal',
                          style: AppTheme.subtitle.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        if (report.createdAt != null)
                          Text(
                            report.createdAt!.split('T')[0],
                            style: AppTheme.body.copyWith(
                              color: Colors.grey,
                              fontSize: 12,
                            ),
                          ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              if (report.photoUrl != null)
                ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.network(
                    report.photoUrl!,
                    height: 150,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
              const SizedBox(height: 16),
              Text(
                report.description ?? 'Tidak ada deskripsi',
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: AppTheme.body,
              ),
              const SizedBox(height: 16),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppTheme.primaryColor,
                    foregroundColor: Colors.white,
                  ),
                  onPressed: () {
                    Navigator.pop(context); // Close bottom sheet
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ReportDetailPage(report: report),
                      ),
                    );
                  },
                  child: const Text('Lihat Detail'),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
