import 'package:plugin_platform_interface/plugin_platform_interface.dart';
import 'offerwall_method_channel.dart';

/// An abstract class that defines the interface for platform-specific implementations of the Offerwall SDK.
abstract class OfferwallPlatform extends PlatformInterface {
  /// Constructs an instance of [OfferwallPlatform].
  ///
  /// This constructor is meant to be used by subclasses only.
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
  ///
  /// This setter is used to override the default instance of the platform interface.
  static set instance(OfferwallPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  /// Configures the Offerwall SDK with the provided [apiKey].
  ///
  /// This method can also take optional parameters:
  /// - [subId]: An optional subscription ID for tracking.
  /// - [userId]: An optional user ID; if not provided, the SDK will generate one.
  ///
  /// Throws an [UnimplementedError] if the platform-specific implementation
  /// has not been provided.
  Future<void> configure(String apiKey, {String? subId, String? userId}) {
    throw UnimplementedError('configure() has not been implemented.');
  }

  /// Launches the Offerwall.
  ///
  /// This method should be called after the SDK has been configured.
  ///
  /// Throws an [UnimplementedError] if the platform-specific implementation
  /// has not been provided.
  Future<void> launch() {
    throw UnimplementedError('launch() has not been implemented.');
  }

  /// Sets the user ID for tracking purposes.
  ///
  /// This method allows you to set a user ID after the SDK has been initialized.
  ///
  /// Throws an [UnimplementedError] if the platform-specific implementation
  /// has not been provided.
  Future<void> setUserId(String userId) {
    throw UnimplementedError('setUserId() has not been implemented.');
  }

  /// Sets the subscription ID for tracking purposes.
  ///
  /// This method allows you to set a sub ID after the SDK has been initialized.
  ///
  /// Throws an [UnimplementedError] if the platform-specific implementation
  /// has not been provided.
  Future<void> setSubId(String subId) {
    throw UnimplementedError('setSubId() has not been implemented.');
  }

  /// Checks for rewards and returns the reward value and conversions.
  ///
  /// This method returns a [String?] representing the reward, which will be `null`
  /// if there is no reward.
  ///
  /// Throws an [UnimplementedError] if the platform-specific implementation
  /// has not been provided.
  Future<String?> checkReward() {
    throw UnimplementedError('checkReward() has not been implemented.');
  }
}
