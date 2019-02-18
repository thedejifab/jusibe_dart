/// Defines delivery status of an SMS
class SMSDeliveryStatus {
  const SMSDeliveryStatus(
      {this.messageID, this.status, this.dateSent, this.dateDelivered});

  factory SMSDeliveryStatus.fromJSON(Map<String, dynamic> json) {
    return SMSDeliveryStatus(
      messageID: json['message_id'],
      status: json['status'],
      dateSent: json['date_sent'],
      dateDelivered: json['date_delivered'],
    );
  }

  final String messageID;
  final String status;
  final String dateSent;
  final String dateDelivered;
}

/// Defines the details of an SMS sending transaction
class SMSDetails {
  const SMSDetails({this.messageID, this.status, this.smsCreditsUsed});

  factory SMSDetails.fromJSON(Map<String, dynamic> json) {
    return SMSDetails(
      status: json['status'],
      messageID: json['message_id'],
      smsCreditsUsed: json['sms_credits_used'],
    );
  }

  final String messageID;
  final String status;
  final int smsCreditsUsed;
}
