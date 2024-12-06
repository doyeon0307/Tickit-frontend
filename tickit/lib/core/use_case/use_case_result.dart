sealed class UseCaseResult<T> {
  const UseCaseResult();
}

class SuccessUseCaseResult<T> extends UseCaseResult<T> {
  final T data;

  const SuccessUseCaseResult({
    required this.data,
  });
}

class FailureUseCaseResult<T> extends UseCaseResult<T> {
  final Object? error;
  final String? message;
  final int? statusCode;

  const FailureUseCaseResult({
    this.error,
    this.message,
    this.statusCode,
  });
}