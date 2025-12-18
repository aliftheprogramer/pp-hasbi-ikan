import '../../domain/entity/fish_entity.dart';

class FishModel extends FishEntity {
  const FishModel({
    super.id,
    super.name,
    super.scientificName,
    super.description,
    super.imageUrl,
    super.dangerLevel,
    super.createdAt,
    super.updatedAt,
  });

  factory FishModel.fromJson(Map<String, dynamic> json) {
    return FishModel(
      id: json['id'],
      name: json['name'],
      scientificName: json['scientificName'],
      description: json['description'],
      imageUrl: json['imageUrl'],
      dangerLevel: json['dangerLevel'],
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'scientificName': scientificName,
      'description': description,
      'imageUrl': imageUrl,
      'dangerLevel': dangerLevel,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
    };
  }

  factory FishModel.fromEntity(FishEntity entity) {
    return FishModel(
      id: entity.id,
      name: entity.name,
      scientificName: entity.scientificName,
      description: entity.description,
      imageUrl: entity.imageUrl,
      dangerLevel: entity.dangerLevel,
      createdAt: entity.createdAt,
      updatedAt: entity.updatedAt,
    );
  }
}
