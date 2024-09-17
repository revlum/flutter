import 'dart:convert';

import 'package:offerwall/entities/check_reward.dart';

import 'offerwall_platform_interface.dart';

class Offerwall {
  Future<void> configure({
    required String apiKey,
    String? subId,
    String? userId,
  }) async {
    await OfferwallPlatform.instance
        .configure(apiKey, subId: subId, userId: userId);
  }

  Future<void> launch() async {
    await OfferwallPlatform.instance.launch();
  }

  Future<void> setUserId(String userId) async {
    await OfferwallPlatform.instance.setUserId(userId);
  }

  Future<void> setSubId(String subId) async {
    await OfferwallPlatform.instance.setSubId(subId);
  }

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
