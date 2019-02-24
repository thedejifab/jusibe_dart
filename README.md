# jusibe_dart ✉️ 

> Jusibe SMS library for Dart. Based on the Official API Documentation provided by [Jusibe](https://www.jusibe.com).

## Installation

Add [jusibe_dart](https://pub.dartlang.org/packages/jusibe) as a dependency in your `pubspec.yaml` file.

```yaml
jusibe_dart: ^0.1.0
```

## Usage

Import the library in your dart file.

```dart
import 'package:jusibe/jusibe.dart';
```

### Initialize SMS 

```dart
Jusibe jusibe = Jusibe.initialize(
    publicKey: 'PUBLIC_KEY_HERE',
    accessToken: 'ACCESS_TOKEN_HERE',
);
```

### Send SMS

This lets you make a request to send an SMS to the Jusibe API. It returns a type `SMSDetails` containing the message status, ID and number of SMS credits used.

```dart
SMSDetails smsDetails = await jusibe.sendSMS(
    from: "Fabusuyi", to: "08101563800", message: "Jusibe test");
print(smsDetails.messageID);
```

### Check SMS Delivery Status

This gives you information on the delivery status of previously sent messages. It returns a type `SMSDeliveryStatus` containing the message status, ID, date sent and date delivered.

```dart
SMSDeliveryStatus smsDeliveryStatus =
    await jusibe.getDeliveryStatus(messageID: 'w53j2p6v12');
print(smsDeliveryStatus.status);
```

### Get SMS Credits

This gives you information about your available SMS credit balance. It returns a type `int` representing the number of units left.

```dart
int creditsRemaining = await jusibe.checkCredits();
print(creditsRemaining);
```

> Check out the example program [here](https://github.com/thedejifab/jusibe_dart/example)

## Contributing

Please feel free to fork this package and contribute by submitting a pull request to enhance its functionalities.

## How can I thank you?

Just star and share the repo 🙂.



