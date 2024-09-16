import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:offerwall/offerwall_method_channel.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  MethodChannelOfferwall platform = MethodChannelOfferwall();
  const MethodChannel channel = MethodChannel('offerwall');

  setUp(() {
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(
      channel,
      (MethodCall methodCall) async {
        return '42';
      },
    );
  });

  tearDown(() {
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(channel, null);
  });
}
