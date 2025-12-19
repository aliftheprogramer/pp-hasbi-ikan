import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:pui_bhasbi_mobile/core/services/location_service.dart';
import '../../../../core/services/service_locator.dart';

import 'dart:developer' as developer;

class DetectMyLocation extends StatefulWidget {
  final Function(LatLng) onLocationChanged;

  const DetectMyLocation({super.key, required this.onLocationChanged});

  @override
  State<DetectMyLocation> createState() => _DetectMyLocationState();
}

class _DetectMyLocationState extends State<DetectMyLocation> {
  final MapController _mapController = MapController();
  LatLng _currentCenter = const LatLng(-7.797068, 110.370529); // Default Jogja

  @override
  void initState() {
    super.initState();
    _locateUser();
  }

  Future<void> _locateUser() async {
    final position = await sl<LocationService>().getCurrentPosition();
    if (!mounted) return;
    if (position != null) {
      final latLng = LatLng(position.latitude, position.longitude);
      setState(() {
        _currentCenter = latLng;
      });
      _mapController.move(latLng, 15);
      widget.onLocationChanged(latLng);
    }
  }

  void _onPositionChanged(MapCamera camera, bool hasGesture) {
    if (hasGesture) {
      setState(() {
        _currentCenter = camera.center;
      });
      widget.onLocationChanged(camera.center);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        FlutterMap(
          mapController: _mapController,
          options: MapOptions(
            initialCenter: _currentCenter,
            initialZoom: 15.0,
            onPositionChanged: _onPositionChanged,
            onTap: (tapPosition, point) {
              // LOGGING START
              developer.log(
                'Map Tapped',
                name: 'DetectMyLocation',
                error: {
                  'latitude': point.latitude,
                  'longitude': point.longitude,
                  'globalPosition': '${tapPosition.global}',
                  'relativePosition': '${tapPosition.relative}',
                },
              );
              print('================ MAP TAP INFO ================');
              print('Latitude: ${point.latitude}');
              print('Longitude: ${point.longitude}');
              print('Screen Position (Global): ${tapPosition.global}');
              print('Screen Position (Relative): ${tapPosition.relative}');
              print('==============================================');
              // LOGGING END

              _mapController.move(point, _mapController.camera.zoom);
              setState(() {
                _currentCenter = point;
              });
              widget.onLocationChanged(point);
            },
          ),
          children: [
            TileLayer(
              urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
              userAgentPackageName: 'com.bhasbi.mobile',
            ),
          ],
        ),
        // Pin in the center
        const Center(
          child: Padding(
            padding: EdgeInsets.only(bottom: 30), // Adjust for pin tip
            child: Icon(Icons.location_on, size: 40, color: Colors.blue),
          ),
        ),
        // Locate Me Button
        Positioned(
          bottom: 100, // Adjust based on where form sits
          right: 20,
          child: FloatingActionButton(
            heroTag: "locate_me_btn",
            onPressed: _locateUser,
            child: const Icon(Icons.my_location),
          ),
        ),
      ],
    );
  }
}
