import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'offerwall_method_channel.dart';

abstract class OfferwallPlatform extends PlatformInterface {
  /// Constructs a OfferwallPlatform.
  OfferwallPlatform() : super(token: _token);

  static final Object _token = Object();

  static OfferwallPlatform _instance = MethodChannelOfferwall();

  /// The default instance of [OfferwallPlatform] to use.
  ///
  /// Defaults to [MethodChannelOfferwall].
  static OfferwallPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [OfferwallPlatform] when
  /// they register themselves.
  static set instance(OfferwallPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<void> configure(String apiKey, {String? subId, String? userId}) {
    throw UnimplementedError('configure() has not been implemented.');
  }

  Future<void> launch() {
    throw UnimplementedError('launch() has not been implemented.');
  }

  Future<void> setUserId(String userId) {
    throw UnimplementedError('setUserId() has not been implemented.');
  }

  Future<void> setSubId(String subId) {
    throw UnimplementedError('setSubId() has not been implemented.');
  }

  Future<String?> checkReward() {
    throw UnimplementedError('checkReward() has not been implemented.');
  }
}
