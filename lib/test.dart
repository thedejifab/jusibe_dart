import 'package:jusibe/jusibe.dart';
import 'package:jusibe/models.dart';

void main() async {
  Jusibe jusibe = Jusibe.initialize(
    publicKey: 'PUBLIC_KEY_HERE',
    accessToken: 'ACCESS_TOKEN_HERE',
  );

  SMSDeliveryStatus smsDeliveryStatus = await jusibe.getDeliveryStatus(messageID: 'w53j2p6v12');
  print(smsDeliveryStatus.status);

  SMSDetails smsDetails = await jusibe.sendSMS(
      from: "Fabusuyi", to: "08101563800", message: "Jusibe test");
  print(smsDetails.messageID);

  int creditsRemaining = await jusibe.checkCredits();
  print(creditsRemaining);
}
