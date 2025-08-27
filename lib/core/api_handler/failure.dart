enum Failure {
  dioFailure,
  forbidden,
  socketFailure,
  authFailure,
  severFailure,
  firebaseFailure,
  formatFailure,
  unknownFailure,
  outOfMemoryError,
  noData,
  timeout,
}

class DataCRUDFailure {
  final Failure failure;
  final String message;

  DataCRUDFailure({required this.failure, required this.message});

  @override
  String toString() {
    return 'DataCRUDFailure(failure: ${failure.name}, message: $message)';
  }
}
