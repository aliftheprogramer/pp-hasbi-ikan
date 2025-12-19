import 'package:equatable/equatable.dart';
import '../../domain/entity/report_entity.dart';

abstract class ApprovedReportsState extends Equatable {
  const ApprovedReportsState();

  @override
  List<Object> get props => [];
}

class ApprovedReportsInitial extends ApprovedReportsState {}

class ApprovedReportsLoading extends ApprovedReportsState {}

class ApprovedReportsSuccess extends ApprovedReportsState {
  final List<ReportEntity> reports;

  const ApprovedReportsSuccess(this.reports);

  @override
  List<Object> get props => [reports];
}

class ApprovedReportsError extends ApprovedReportsState {
  final String message;

  const ApprovedReportsError(this.message);

  @override
  List<Object> get props => [message];
}
