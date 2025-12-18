import 'package:equatable/equatable.dart';
import '../../domain/entity/report_entity.dart';

abstract class ReportState extends Equatable {
  const ReportState();

  @override
  List<Object?> get props => [];
}

class ReportInitial extends ReportState {}

class ReportLoading extends ReportState {}

class ReportLoaded extends ReportState {
  final List<ReportEntity> reports;

  const ReportLoaded(this.reports);

  @override
  List<Object?> get props => [reports];
}

class ReportSubmissionSuccess extends ReportState {
  final ReportEntity report;

  const ReportSubmissionSuccess(this.report);

  @override
  List<Object?> get props => [report];
}

class ReportError extends ReportState {
  final String message;

  const ReportError(this.message);

  @override
  List<Object?> get props => [message];
}
