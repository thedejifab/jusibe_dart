import 'package:jusibe/src/exceptions.dart';
import 'package:jusibe/src/models.dart';
import 'package:jusibe/src/utils.dart';
import 'package:dio/dio.dart';
import 'package:meta/meta.dart';

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
  Future<SMSDetails> sendSMS({
    @required String from,
    @required String to,
    @required String message,
  }) async {
    Map responseBody;
    SMSDetails returnable;

    try {
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

      responseBody = response.data;

      if (response.statusCode == 200) {
        returnable = SMSDetails.fromJSON(responseBody);
      }
    } on DioError catch (error) {
      if (error.response != null) {
        var response = error.response;
        responseBody = response.data;

        if (response.statusCode == 401) {
          throw FailedAuthException(responseBody['error']);
        } else if (response.statusCode == 400) {
          throw SMSDetailsException(
              responseBody[responseBody.keys.elementAt(0)]);
        }
      } else {
        throw Exception("Failed to send SMS");
      }
    }
    return returnable;
  }

  /// To get available SMS credits in Jusibe account
  /// Returns [int]
  Future<int> checkCredits() async {
    Map responseBody;
    int returnable;

    try {
      final response = await _client.get(
        'get_credits',
        options: RequestOptions(
          headers: {
            "Authorization": keysToBasicAuth(_publicKey, _accessToken),
          },
        ),
      );

      responseBody = response.data;

      if (response.statusCode == 200) {
        returnable = int.parse(responseBody['sms_credits']);
      }
    } on DioError catch (error) {
      if (error.response != null) {
        var response = error.response;
        responseBody = response.data;

        if (response.statusCode == 401) {
          throw FailedAuthException(responseBody['error']);
        }
      } else {
        throw Exception("Failed to send SMS");
      }
    }

    return returnable;
  }

  /// To get the delivery status of message with ID [messageID]
  /// Returns [SMSDeliveryStatus] type
  Future<SMSDeliveryStatus> getDeliveryStatus(
      {@required String messageID}) async {
    Map responseBody;
    SMSDeliveryStatus returnable;

    try {
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

      responseBody = response.data;

      if (response.statusCode == 200) {
        returnable = SMSDeliveryStatus.fromJSON(responseBody);
      }
    } on DioError catch (error) {
      if (error.response != null) {
        var response = error.response;
        responseBody = response.data;

        if (response.statusCode == 401) {
          throw FailedAuthException(responseBody['error']);
        } else if (response.statusCode == 400) {
          throw SMSDeliveryException(responseBody['invalid_message_id']);
        }
      } else {
        throw Exception('Failed to get message delivery status');
      }
    }

    return returnable;
  }
}
