import 'package:equatable/equatable.dart';
import '../../domain/entity/fish_entity.dart';

abstract class FishState extends Equatable {
  const FishState();

  @override
  List<Object?> get props => [];
}

class FishInitial extends FishState {}

class FishLoading extends FishState {}

class FishLoaded extends FishState {
  final List<FishEntity> fishList;

  const FishLoaded(this.fishList);

  @override
  List<Object?> get props => [fishList];
}

class FishDetailLoaded extends FishState {
  final FishEntity fish;

  const FishDetailLoaded(this.fish);

  @override
  List<Object?> get props => [fish];
}

class FishError extends FishState {
  final String message;

  const FishError(this.message);

  @override
  List<Object?> get props => [message];
}
