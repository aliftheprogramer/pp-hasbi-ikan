import 'package:equatable/equatable.dart';

class FishEntity extends Equatable {
  final String? id;
  final String? name;
  final String? scientificName;
  final String? description;
  final String? imageUrl;
  final String? dangerLevel;
  final String? createdAt;
  final String? updatedAt;

  const FishEntity({
    this.id,
    this.name,
    this.scientificName,
    this.description,
    this.imageUrl,
    this.dangerLevel,
    this.createdAt,
    this.updatedAt,
  });

  @override
  List<Object?> get props {
    return [
      id,
      name,
      scientificName,
      description,
      imageUrl,
      dangerLevel,
      createdAt,
      updatedAt,
    ];
  }
}
