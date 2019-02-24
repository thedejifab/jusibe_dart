import 'dart:convert';

/// To convert public Key + access token to
/// base64 String sendable as Basic auth header
String keysToBasicAuth(String publicKey, String accessToken) {
  String basicAuth =
      'Basic ' + base64Encode(utf8.encode('$publicKey:$accessToken'));

  return basicAuth;
}
