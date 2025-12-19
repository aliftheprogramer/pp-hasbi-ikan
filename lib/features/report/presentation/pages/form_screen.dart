import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:latlong2/latlong.dart';
import 'package:pui_bhasbi_mobile/common/widget/text_form_field_custom.dart';
import '../../../../common/theme/app_theme.dart';
import '../../../../common/widget/custom_button.dart';

class FormScreen extends StatefulWidget {
  final LatLng coordinate;
  final String? address; // NEW
  final Function() onSubmit;
  final Function() onCancel; // NEW
  final Function(String description, File? photo) onFormChanged;
  final bool isLoading;

  const FormScreen({
    super.key,
    required this.coordinate,
    this.address, // NEW
    required this.onSubmit,
    required this.onCancel, // NEW
    required this.onFormChanged,
    this.isLoading = false,
  });

  @override
  State<FormScreen> createState() => _FormScreenState();
}

class _FormScreenState extends State<FormScreen> {
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _coordController = TextEditingController();
  final TextEditingController _descController = TextEditingController();
  File? _selectedImage;
  final ImagePicker _picker = ImagePicker();

  @override
  void initState() {
    super.initState();
    _updateCoordinates();
  }

  @override
  void didUpdateWidget(covariant FormScreen oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.coordinate != widget.coordinate ||
        oldWidget.address != widget.address) {
      _updateCoordinates();
    }
  }

  void _updateCoordinates() {
    _coordController.text =
        "${widget.coordinate.latitude.toStringAsFixed(6)}, ${widget.coordinate.longitude.toStringAsFixed(6)}";
    // Use the passed address or fallback to coordinates
    _addressController.text = widget.address ?? "Mencari alamat...";
  }

  Future<void> _pickImage() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.camera);
    if (image != null) {
      setState(() {
        _selectedImage = File(image.path);
      });
      widget.onFormChanged(_descController.text, _selectedImage);
    }
  }

  void _onDescChanged(String val) {
    widget.onFormChanged(val, _selectedImage);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onVerticalDragEnd: (details) {
        if (details.primaryVelocity! > 0) {
          // Swipe down
          widget.onCancel();
        }
      },
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 10,
              offset: Offset(0, -5),
            ),
          ],
        ),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Center(
                child: Container(
                  width: 40,
                  height: 4,
                  margin: const EdgeInsets.only(bottom: 16),
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ),
              Text("Laporan", style: AppTheme.heading1.copyWith(fontSize: 18)),
              const SizedBox(height: 16),
              CustomTextFormField(
                controller: _addressController,
                label: "Alamat Laporan",
                readOnly: true,
                maxLines: 2,
              ),
              const SizedBox(height: 16),
              CustomTextFormField(
                controller: _coordController,
                label: "Koordinat",
                readOnly: true,
              ),
              const SizedBox(height: 16),
              CustomTextFormField(
                controller: _descController,
                label: "Deskripsi",
                hintText: "Masukan detail laporan",
                maxLines: 3,
                onChanged: _onDescChanged,
              ),
              const SizedBox(height: 16),
              Text("Bukti Laporan", style: AppTheme.bodyText1),
              const SizedBox(height: 8),
              GestureDetector(
                onTap: _pickImage,
                child: _selectedImage != null
                    ? ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Image.file(
                          _selectedImage!,
                          height: 150,
                          width: double.infinity,
                          fit: BoxFit.cover,
                        ),
                      )
                    : DottedBorder(
                        child: Container(
                          height: 150,
                          width: double.infinity,
                          alignment: Alignment.center,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Icon(Icons.camera_alt, color: Colors.grey),
                              Text(
                                "Upload Gambar",
                                style: AppTheme.bodyText1.copyWith(
                                  color: Colors.grey,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
              ),
              const SizedBox(height: 24),
              Row(
                children: [
                  Expanded(
                    child: CustomButton(
                      text: "Batal",
                      onPressed: widget.onCancel, // Use callback
                      backgroundColor: Colors.grey.shade300,
                      textColor: Colors.black,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: CustomButton(
                      text: "Kirim Laporan",
                      isLoading: widget.isLoading,
                      onPressed: widget.onSubmit,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
