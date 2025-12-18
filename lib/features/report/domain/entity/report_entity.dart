import 'package:equatable/equatable.dart';

class ReportEntity extends Equatable {
  final String? id;
  final String? userId;
  final String? fishReferenceId;
  final String? description;
  final String? photoUrl;
  final double? latitude;
  final double? longitude;
  final String? addressText;
  final String? status;
  final String? adminNote;
  final String? createdAt;
  final String? updatedAt;
  final FishReferenceEntity? fishReference;
  final UserReferenceEntity? user;

  const ReportEntity({
    this.id,
    this.userId,
    this.fishReferenceId,
    this.description,
    this.photoUrl,
    this.latitude,
    this.longitude,
    this.addressText,
    this.status,
    this.adminNote,
    this.createdAt,
    this.updatedAt,
    this.fishReference,
    this.user,
  });

  @override
  List<Object?> get props => [
    id,
    userId,
    fishReferenceId,
    description,
    photoUrl,
    latitude,
    longitude,
    addressText,
    status,
    adminNote,
    createdAt,
    updatedAt,
    fishReference,
    user,
  ];
}

class FishReferenceEntity extends Equatable {
  final String? id;
  final String? name;
  final String? scientificName;
  final String? imageUrl;
  final String? dangerLevel;

  const FishReferenceEntity({
    this.id,
    this.name,
    this.scientificName,
    this.imageUrl,
    this.dangerLevel,
  });

  @override
  List<Object?> get props => [id, name, scientificName, imageUrl, dangerLevel];
}

class UserReferenceEntity extends Equatable {
  final String? id;
  final String? name;
  final String? avatarUrl;

  const UserReferenceEntity({this.id, this.name, this.avatarUrl});

  @override
  List<Object?> get props => [id, name, avatarUrl];
}
