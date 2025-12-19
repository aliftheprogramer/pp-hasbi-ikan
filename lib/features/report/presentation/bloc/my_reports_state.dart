import 'package:equatable/equatable.dart';
import '../../domain/entity/report_entity.dart';

abstract class MyReportsState extends Equatable {
  const MyReportsState();

  @override
  List<Object> get props => [];
}

class MyReportsInitial extends MyReportsState {}

class MyReportsLoading extends MyReportsState {}

class MyReportsSuccess extends MyReportsState {
  final List<ReportEntity> reports;

  const MyReportsSuccess(this.reports);

  @override
  List<Object> get props => [reports];
}

class MyReportsError extends MyReportsState {
  final String message;

  const MyReportsError(this.message);

  @override
  List<Object> get props => [message];
}
