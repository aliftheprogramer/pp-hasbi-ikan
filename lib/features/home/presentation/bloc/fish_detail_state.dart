import 'package:equatable/equatable.dart';
import '../../domain/entity/fish_entity.dart';

abstract class FishDetailState extends Equatable {
  const FishDetailState();

  @override
  List<Object?> get props => [];
}

class FishDetailInitial extends FishDetailState {}

class FishDetailLoading extends FishDetailState {}

class FishDetailSuccess extends FishDetailState {
  final FishEntity fish;

  const FishDetailSuccess(this.fish);

  @override
  List<Object?> get props => [fish];
}

class FishDetailFailure extends FishDetailState {
  final String message;

  const FishDetailFailure(this.message);

  @override
  List<Object?> get props => [message];
}
