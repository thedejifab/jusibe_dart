import 'dart:convert';

import 'package:jusibe/exceptions.dart';
import 'package:jusibe/response.dart';
import 'package:jusibe/utils.dart';
import 'package:meta/meta.dart';
import 'package:dio/dio.dart';

class Jusibe {
  /// Jusibe public key
  String _publicKey;

  /// Jusibe access token
  String _accessToken;

  /// Jusibe base URL
  final String _baseURL = 'https://jusibe.com/smsapi/';

  Dio _client;

  /// To initialize Jusibe message transactions
  /// using [publicKey] and [accessToken]
  Jusibe.initialize({
    @required String publicKey,
    @required String accessToken,
  }) {
    if (publicKey == null) {
      throw IsNullException('The public key cannot be null');
    }
    if (accessToken == null) {
      throw IsNullException('The access token cannot be null');
    }
    this._publicKey = publicKey;
    this._accessToken = accessToken;
    _initializeDio();
  }

  /// Initialize Dio client for network requests
  void _initializeDio() {
    _client = Dio(BaseOptions(baseUrl: _baseURL));
  }

  /// To send SMS
  /// [from] - Sender ID (alphanumeric/alphabetic)
  /// [to] - Receipient's mobile number
  /// [message] - Message being sent
  Future<JusibeResponse> sendSMS({
    @required String from,
    @required String to,
    @required String message,
  }) async {
    final response = await _client.post(
      'send_sms',
      data: {
        "to": to,
        "from": from,
        "message": message,
      },
      options: RequestOptions(
        headers: {
          "Authorization": keysToBasicAuth(_publicKey, _accessToken),
        },
      ),
    );

    if (response.statusCode == 200) {
    } else if (response.statusCode == 401) {
    } else if (response.statusCode == 400) {}
  }

  /// To get available SMS credits in Jusibe account
  Future<int> checkCredits() async {
    Map responseBody;
    final response = await _client.get(
      'get_credits',
      options: RequestOptions(
        headers: {
          "Authorization": keysToBasicAuth(_publicKey, _accessToken),
        },
      ),
    );

    responseBody = json.decode(response.data);

    if (response.statusCode == 200) {
      return responseBody['sms_credits'];
    } else if (response.statusCode == 401) {
      throw FailedAuthException(responseBody['error']);
    } else {
      throw Exception("Failed to get SMS credits");
    }
  }

  /// To get the delivery status of message with ID [messageID]
  Future<JusibeResponse> getDeliveryStatus({@required String messageID}) async {
    final response = await _client.get(
      'delivery_status',
      queryParameters: {
        "message_id": messageID,
      },
      options: RequestOptions(
        headers: {
          "Authorization": keysToBasicAuth(_publicKey, _accessToken),
        },
      ),
    );
    //HANDLE RESPONSE
  }
}
