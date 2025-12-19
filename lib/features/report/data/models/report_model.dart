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
    // Check if we have a nested _doc object (raw Mongoose document)
    final data = json['_doc'] is Map<String, dynamic> ? json['_doc'] : json;

    return ReportModel(
      id: data['_id'] ?? data['id'],
      userId: data['userId'] ?? data['user_id'],
      fishReferenceId: data['fishReferenceId'] ?? data['fish_reference_id'],
      description: data['description'],
      photoUrl: data['photoUrl'] ?? data['photo_url'],
      latitude: (data['latitude'] as num?)?.toDouble(),
      longitude: (data['longitude'] as num?)?.toDouble(),
      addressText: data['addressText'] ?? data['address_text'],
      status: data['status'],
      adminNote: data['adminNote'] ?? data['admin_note'],
      createdAt: data['createdAt'] ?? data['created_at'],
      updatedAt: data['updatedAt'] ?? data['updated_at'],
      // Virtuals might be at the root or inside data depending on serialization
      fishReference: (json['fishReference'] != null)
          ? FishReferenceModel.fromJson(json['fishReference'])
          : (data['fishReference'] != null)
          ? FishReferenceModel.fromJson(data['fishReference'])
          : null,
      user: (json['user'] != null)
          ? UserReferenceModel.fromJson(json['user'])
          : (data['user'] != null)
          ? UserReferenceModel.fromJson(data['user'])
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
    // Check if we have a nested _doc object
    final data = json['_doc'] is Map<String, dynamic> ? json['_doc'] : json;

    return FishReferenceModel(
      id: data['_id'] ?? data['id'],
      name: data['name'],
      scientificName: data['scientificName'],
      imageUrl: data['imageUrl'] ?? data['image_url'],
      dangerLevel: data['dangerLevel'],
    );
  }
}

class UserReferenceModel extends UserReferenceEntity {
  const UserReferenceModel({super.id, super.name, super.avatarUrl});

  factory UserReferenceModel.fromJson(Map<String, dynamic> json) {
    // Check if we have a nested _doc object
    final data = json['_doc'] is Map<String, dynamic> ? json['_doc'] : json;

    return UserReferenceModel(
      id: data['_id'] ?? data['id'],
      name: data['name'],
      avatarUrl: data['avatarUrl'] ?? data['avatar_url'],
    );
  }
}
