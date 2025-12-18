import '../../domain/entity/report_entity.dart';

class ReportModel extends ReportEntity {
  const ReportModel({
    super.id,
    super.userId,
    super.fishReferenceId,
    super.description,
    super.photoUrl,
    super.latitude,
    super.longitude,
    super.addressText,
    super.status,
    super.adminNote,
    super.createdAt,
    super.updatedAt,
    super.fishReference,
    super.user,
  });

  factory ReportModel.fromJson(Map<String, dynamic> json) {
    return ReportModel(
      id: json['id'],
      userId: json['userId'],
      fishReferenceId: json['fishReferenceId'],
      description: json['description'],
      photoUrl: json['photoUrl'],
      latitude: (json['latitude'] as num?)?.toDouble(),
      longitude: (json['longitude'] as num?)?.toDouble(),
      addressText: json['addressText'],
      status: json['status'],
      adminNote: json['adminNote'],
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
      fishReference: json['fishReference'] != null
          ? FishReferenceModel.fromJson(json['fishReference'])
          : null,
      user: json['user'] != null
          ? UserReferenceModel.fromJson(json['user'])
          : null,
    );
  }
}

class FishReferenceModel extends FishReferenceEntity {
  const FishReferenceModel({
    super.id,
    super.name,
    super.scientificName,
    super.imageUrl,
    super.dangerLevel,
  });

  factory FishReferenceModel.fromJson(Map<String, dynamic> json) {
    return FishReferenceModel(
      id: json['id'],
      name: json['name'],
      scientificName: json['scientificName'],
      imageUrl: json['imageUrl'],
      dangerLevel: json['dangerLevel'],
    );
  }
}

class UserReferenceModel extends UserReferenceEntity {
  const UserReferenceModel({super.id, super.name, super.avatarUrl});

  factory UserReferenceModel.fromJson(Map<String, dynamic> json) {
    return UserReferenceModel(
      id: json['id'],
      name: json['name'],
      avatarUrl: json['avatarUrl'],
    );
  }
}
