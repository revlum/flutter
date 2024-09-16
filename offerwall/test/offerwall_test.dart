import 'package:flutter_test/flutter_test.dart';
import 'package:offerwall/offerwall_platform_interface.dart';
import 'package:offerwall/offerwall_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockOfferwallPlatform
    with MockPlatformInterfaceMixin
    implements OfferwallPlatform {
  @override
  Future<String?> checkReward() {
    // TODO: implement checkReward
    throw UnimplementedError();
  }

  @override
  Future<void> configure(String apiKey, {String? subId, String? userId}) {
    // TODO: implement configure
    throw UnimplementedError();
  }

  @override
  Future<void> launch() {
    // TODO: implement launch
    throw UnimplementedError();
  }

  @override
  Future<void> setSubId(String subId) {
    // TODO: implement setSubId
    throw UnimplementedError();
  }

  @override
  Future<void> setUserId(String userId) {
    // TODO: implement setUserId
    throw UnimplementedError();
  }
}

void main() {
  final OfferwallPlatform initialPlatform = OfferwallPlatform.instance;

  test('$MethodChannelOfferwall is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelOfferwall>());
  });
}
