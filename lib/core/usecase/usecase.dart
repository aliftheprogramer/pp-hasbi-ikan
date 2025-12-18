// lib/core/usecase/usecase.dart

abstract class Usecase<T, Param> {
  Future<T> call({Param? param});
}
