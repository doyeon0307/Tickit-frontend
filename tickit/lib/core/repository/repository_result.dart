sealed class RepositoryResult<T> {
  const RepositoryResult();
}

class SuccessRepositoryResult<T> extends RepositoryResult<T> {
  final T data;

  const SuccessRepositoryResult({required this.data});
}

class FailureRepositoryResult<T> extends RepositoryResult<T> {
  final Object? error;
  final List<String>? messages;
  final int? statusCode;

  const FailureRepositoryResult({
    this.error,
    this.messages,
    this.statusCode,
  });
}