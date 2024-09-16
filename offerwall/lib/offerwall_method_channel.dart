import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'offerwall_platform_interface.dart';

/// An implementation of [OfferwallPlatform] that uses method channels.
class MethodChannelOfferwall extends OfferwallPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('offerwall');

  @override
  Future<void> configure(String apiKey, {String? subId, String? userId}) async {
    try {
      await methodChannel.invokeMethod('configure', {
        'apiKey': apiKey,
        'subId': subId,
        'userId': userId,
      });
    } on PlatformException {
      rethrow;
    } catch (e) {
      throw PlatformException(
          code: 'CONFIGURE_ERROR',
          message: 'Failed to configure offerwall: $e');
    }
  }

  @override
  Future<void> launch() async {
    try {
      await methodChannel.invokeMethod('launch');
    } on PlatformException {
      rethrow;
    } catch (e) {
      throw PlatformException(
          code: 'LAUNCH_ERROR', message: 'Failed to launch: $e');
    }
  }

  @override
  Future<void> setUserId(String userId) async {
    try {
      await methodChannel.invokeMethod('setUserId', {'userId': userId});
    } on PlatformException {
      rethrow;
    } catch (e) {
      throw PlatformException(
          code: 'SET_USER_ID_ERROR', message: 'Failed to set user ID: $e');
    }
  }

  @override
  Future<void> setSubId(String subId) async {
    try {
      await methodChannel.invokeMethod('setSubId', {'subId': subId});
    } on PlatformException {
      rethrow;
    } catch (e) {
      throw PlatformException(
          code: 'SET_SUB_ID_ERROR', message: 'Failed to set sub ID: $e');
    }
  }

  @override
  Future<String?> checkReward() async {
    try {
      final checkReward =
          await methodChannel.invokeMethod<String>('checkReward');
      return checkReward;
    } on PlatformException {
      rethrow;
    } catch (e) {
      throw PlatformException(
          code: 'CHECK_REWARD_ERROR', message: 'Failed to check reward: $e');
    }
  }
}
