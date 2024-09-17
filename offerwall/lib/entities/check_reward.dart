import 'offer.dart';

/// A class that represents the result of a reward check in the Offerwall SDK.
class CheckReward {
  /// A list of [Offer] instances associated with the reward check.
  final List<Offer> offers;

  /// The total reward value received from the reward check.
  final double reward;

  /// Constructs an instance of [CheckReward] with the required parameters.
  CheckReward({required this.offers, required this.reward});

  /// Creates a [CheckReward] instance from a JSON map.
  ///
  /// The [json] parameter should contain the following keys:
  /// - 'offers': A list of offers associated with the reward.
  /// - 'reward': The total reward value received.
  factory CheckReward.fromJson(Map<String, dynamic> json) {
    var offersList = (json['offers'] as List)
        .map((offerJson) => Offer.fromJson(offerJson))
        .toList();

    return CheckReward(
      offers: offersList,
      reward: (json['reward'] as num).toDouble(),
    );
  }
}
