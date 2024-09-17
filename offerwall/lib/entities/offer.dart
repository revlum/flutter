/// A class that represents an offer in the Offerwall SDK.
class Offer {
  /// The status of the offer (e.g., "approved", "rejected").
  final String status;

  /// The unique identifier of the offer.
  final String id;

  /// The name of the offer.
  final String name;

  /// The revenue associated with the offer.
  final double revenue;

  /// The reward value of the offer.
  final double reward;

  /// The transaction ID associated with the offer.
  final String transactionId;

  /// The timestamp when the offer was created or modified.
  final int time;

  /// Constructs an instance of [Offer] with the required parameters.
  Offer({
    required this.status,
    required this.id,
    required this.name,
    required this.revenue,
    required this.reward,
    required this.transactionId,
    required this.time,
  });

  /// Creates an [Offer] instance from a JSON map.
  ///
  /// The [json] parameter should contain the following keys:
  /// - 'status': The status of the offer.
  /// - 'id': The unique identifier of the offer.
  /// - 'name': The name of the offer.
  /// - 'revenue': The revenue associated with the offer.
  /// - 'reward': The reward value of the offer.
  /// - 'transactionId': The transaction ID associated with the offer.
  /// - 'time': The timestamp of the offer.
  factory Offer.fromJson(Map<String, dynamic> json) {
    return Offer(
      status: json['status'] as String,
      id: json['id'] as String,
      name: json['name'] as String,
      revenue: (json['revenue'] as num).toDouble(),
      reward: (json['reward'] as num).toDouble(),
      transactionId: json['transactionId'] as String,
      time: json['time'] as int,
    );
  }
}
