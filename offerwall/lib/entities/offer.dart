class Offer {
  final String status;
  final String id;
  final String name;
  final double revenue;
  final double reward;
  final String transactionId;
  final int time;

  Offer({
    required this.status,
    required this.id,
    required this.name,
    required this.revenue,
    required this.reward,
    required this.transactionId,
    required this.time,
  });

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
