import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'offerwall_platform_interface.dart';

/// An implementation of [OfferwallPlatform] that uses method channels.
class MethodChannelOfferwall extends OfferwallPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('offerwall');

  @override
  Future<String?> getPlatformVersion() async {
    final version = await methodChannel.invokeMethod<String>('getPlatformVersion');
    return version;
  }
}
