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
