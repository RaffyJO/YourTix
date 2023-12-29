sealed class Result<T> {
  const Result();

  const factory Result.success(T value) = Success;
  const factory Result.failed(String massage) = Failed;

  bool get isSucces => this is Success<T>;
  bool get isFailed => this is Failed<T>;

  T? get resultValue => isSucces ? (this as Success<T>).value : null;
  String? get errorMassage => isFailed ? (this as Failed<T>).message : null;
}

class Success<T> extends Result<T> {
  final T value;

  const Success(this.value);
}

class Failed<T> extends Result<T> {
  final String message;

  const Failed(this.message);
}
