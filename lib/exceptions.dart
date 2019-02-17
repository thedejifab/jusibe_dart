class IsNullException implements Exception {
  final String message;

  const IsNullException(this.message);

  @override
  String toString() => 'IsNullException: $message';
}

class IsEmptyException implements Exception {
  final String message;

  const IsEmptyException(this.message);

  @override
  String toString() => 'IsEmptyException: $message';
}
