import 'dart:io';
import 'package:equatable/equatable.dart';

class ReportRequestEntity extends Equatable {
  final File photo;
  final String description;
  final double latitude;
  final double longitude;
  final String? addressText;
  final String? fishReferenceId;

  const ReportRequestEntity({
    required this.photo,
    required this.description,
    required this.latitude,
    required this.longitude,
    this.addressText,
    this.fishReferenceId,
  });

  @override
  List<Object?> get props => [
    photo,
    description,
    latitude,
    longitude,
    addressText,
    fishReferenceId,
  ];
}
