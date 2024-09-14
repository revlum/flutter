import 'package:flutter_test/flutter_test.dart';
import 'package:offerwall/offerwall.dart';
import 'package:offerwall/offerwall_platform_interface.dart';
import 'package:offerwall/offerwall_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockOfferwallPlatform
    with MockPlatformInterfaceMixin
    implements OfferwallPlatform {

  @override
  Future<String?> getPlatformVersion() => Future.value('42');
}

void main() {
  final OfferwallPlatform initialPlatform = OfferwallPlatform.instance;

  test('$MethodChannelOfferwall is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelOfferwall>());
  });

  test('getPlatformVersion', () async {
    Offerwall offerwallPlugin = Offerwall();
    MockOfferwallPlatform fakePlatform = MockOfferwallPlatform();
    OfferwallPlatform.instance = fakePlatform;

    expect(await offerwallPlugin.getPlatformVersion(), '42');
  });
}
