import 'offer.dart';

class CheckReward {
  final List<Offer> offers;
  final double reward;

  CheckReward({required this.offers, required this.reward});

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
