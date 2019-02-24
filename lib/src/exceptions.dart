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

class FailedAuthException implements Exception {
  final String message;

  const FailedAuthException(this.message);

  @override
  String toString() => 'FailedAuthException: $message';
}

class SMSDeliveryException implements Exception {
  final String message;

  const SMSDeliveryException(this.message);

  @override
  String toString() => 'SMSDeliveryException: $message';
}

class SMSDetailsException implements Exception {
  final String message;

  const SMSDetailsException(this.message);

  @override
  String toString() => 'SMSSendingException: $message';
}
