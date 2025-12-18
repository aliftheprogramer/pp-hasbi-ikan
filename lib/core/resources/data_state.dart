import 'package:dio/dio.dart';

abstract class DataState<T> {
  final T? data;
  final DioException? error;
  final T? messages;
  final T? success;

  const DataState({this.data, this.error, this.messages, this.success});
}

class DataSuccess<T> extends DataState<T> {
  const DataSuccess({super.data, super.messages, super.success});
}

class DataFailed<T> extends DataState<T> {
  const DataFailed(DioException error) : super(error: error);
}
