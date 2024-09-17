import 'dart:convert';
import 'package:offerwall/entities/check_reward.dart';
import 'offerwall_platform_interface.dart';

/// A class that provides an interface for interacting with the Offerwall SDK.
class Offerwall {
  /// Configures the Offerwall SDK with the provided [apiKey].
  ///
  /// This method can also take optional parameters:
  /// - [subId]: An optional subscription ID for tracking.
  /// - [userId]: An optional user ID; if not provided, the SDK will generate one.
  Future<void> configure({
    required String apiKey,
    String? subId,
    String? userId,
  }) async {
    await OfferwallPlatform.instance
        .configure(apiKey, subId: subId, userId: userId);
  }

  /// Launches the Offerwall.
  ///
  /// This method should be called after the SDK has been configured.
  Future<void> launch() async {
    await OfferwallPlatform.instance.launch();
  }

  /// Sets the user ID for tracking purposes.
  ///
  /// This method allows you to set a user ID after the SDK has been initialized.
  Future<void> setUserId(String userId) async {
    await OfferwallPlatform.instance.setUserId(userId);
  }

  /// Sets the subscription ID for tracking purposes.
  ///
  /// This method allows you to set a sub ID after the SDK has been initialized.
  Future<void> setSubId(String subId) async {
    await OfferwallPlatform.instance.setSubId(subId);
  }

  /// Checks for rewards and returns a [CheckReward] object.
  ///
  /// This method retrieves reward data and parses it into a [CheckReward] object.
  /// If no reward data is available, it throws an exception.
  Future<CheckReward> checkReward() async {
    final checkRewardData = await OfferwallPlatform.instance.checkReward();
    if (checkRewardData != null) {
      final Map<String, dynamic> checkRewardMap = jsonDecode(checkRewardData);
      return CheckReward.fromJson(checkRewardMap);
    } else {
      throw Exception("Failed to retrieve reward data.");
    }
  }
}
