import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:latlong2/latlong.dart';
import 'package:pui_bhasbi_mobile/common/widget/custom_button.dart';
import 'package:pui_bhasbi_mobile/features/report/domain/entity/report_request_entity.dart';
import 'package:pui_bhasbi_mobile/features/report/presentation/bloc/report_cubit.dart';
import 'package:pui_bhasbi_mobile/features/report/presentation/bloc/report_state.dart';
import '../../../../core/services/service_locator.dart';
import 'package:pui_bhasbi_mobile/core/services/location_service.dart';
import 'detect_my_location.dart';
import 'form_screen.dart';

class ReportPage extends StatefulWidget {
  const ReportPage({super.key});

  @override
  State<ReportPage> createState() => _ReportPageState();
}

class _ReportPageState extends State<ReportPage> {
  LatLng? _selectedLocation;
  String? _currentAddress;
  bool _showForm = false;
  String _description = "";
  File? _photo;

  Future<void> _onLocationChanged(LatLng newLocation) async {
    setState(() {
      _selectedLocation = newLocation;
    });

    // Fetch address
    final address = await sl<LocationService>().getAddressFromLatLng(
      newLocation.latitude,
      newLocation.longitude,
    );

    if (mounted) {
      setState(() {
        _currentAddress = address;
      });
    }
  }

  void _toggleForm() {
    setState(() {
      _showForm = !_showForm;
    });
  }

  void _onFormChanged(String desc, File? photo) {
    _description = desc;
    _photo = photo;
  }

  void _submitReport(BuildContext context) {
    if (_selectedLocation == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Mohon tunggu, sedang mencari lokasi...")),
      );
      return;
    }
    if (_photo == null) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text("Gambar wajib diisi!")));
      return;
    }
    if (_description.isEmpty) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text("Deskripsi wajib diisi!")));
      return;
    }

    final request = ReportRequestEntity(
      photo: _photo!,
      description: _description,
      latitude: _selectedLocation!.latitude,
      longitude: _selectedLocation!.longitude,
      addressText:
          _currentAddress ??
          "${_selectedLocation!.latitude}, ${_selectedLocation!.longitude}",
    );

    context.read<ReportCubit>().submitReport(request);
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<ReportCubit>(),
      child: Scaffold(
        body: BlocConsumer<ReportCubit, ReportState>(
          listener: (context, state) {
            if (state is ReportSubmissionSuccess) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text("Laporan berhasil dikirim!")),
              );
              // Reset
              setState(() {
                _showForm = false;
                _description = "";
                _photo = null;
                _selectedLocation = null;
                _currentAddress = null;
              });
            } else if (state is ReportError) {
              ScaffoldMessenger.of(
                context,
              ).showSnackBar(SnackBar(content: Text(state.message)));
            }
          },
          builder: (context, state) {
            return Stack(
              children: [
                // Layer 1: Map
                Positioned.fill(
                  child: DetectMyLocation(
                    onLocationChanged: _onLocationChanged,
                  ),
                ),

                // Button "Laporkan" (Visible when form is hidden)
                if (!_showForm)
                  Positioned(
                    bottom: 24,
                    left: 24,
                    right: 24,
                    child: CustomButton(
                      text: "Laporkan",
                      onPressed: _toggleForm,
                    ),
                  ),

                // Layer 2: Form (Slide up or Bottom Sheet)
                if (_showForm)
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: ConstrainedBox(
                      constraints: BoxConstraints(
                        maxHeight: MediaQuery.of(context).size.height * 0.75,
                      ),
                      child: _selectedLocation != null
                          ? FormScreen(
                              coordinate: _selectedLocation!,
                              address: _currentAddress,
                              isLoading: state is ReportLoading,
                              onFormChanged: _onFormChanged,
                              onCancel: _toggleForm, // NEW
                              onSubmit: () => _submitReport(context),
                            )
                          : const SizedBox.shrink(), // Should not happen due to if (_showForm) logic but safe
                    ),
                  ),

                // Address Overlay Top (Like Image 1) - Only when form hidden?
                // Or always visible? Image 1 has it. Image 2 has it inside form.
                // Assuming Image 1 is "Detect Mode".
                if (!_showForm)
                  Positioned(
                    top: 60,
                    left: 16,
                    right: 16,
                    child: Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.blue,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        _selectedLocation != null
                            ? "${_currentAddress ?? 'Mencari alamat...'}\n(${_selectedLocation!.latitude.toStringAsFixed(5)}, ${_selectedLocation!.longitude.toStringAsFixed(5)})"
                            : "Mencari lokasi kamu...",
                        style: const TextStyle(color: Colors.white),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
              ],
            );
          },
        ),
      ),
    );
  }
}
