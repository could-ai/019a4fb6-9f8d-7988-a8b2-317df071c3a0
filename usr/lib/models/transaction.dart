enum TransactionType { deposit, withdrawal, productPurchase, referralBonus, loginBonus }

class Transaction {
  String id;
  TransactionType type;
  double amount;
  DateTime date;
  String status; // 'pending', 'validated', 'rejected'
  String? proofImagePath; // Pour dépôts
  Map<String, dynamic>? details; // Infos supplémentaires (produit, moyen paiement, etc.)

  Transaction({
    required this.id,
    required this.type,
    required this.amount,
    required this.date,
    this.status = 'pending',
    this.proofImagePath,
    this.details,
  });

  factory Transaction.fromJson(Map<String, dynamic> json) {
    return Transaction(
      id: json['id'],
      type: TransactionType.values[json['type']],
      amount: json['amount'],
      date: DateTime.parse(json['date']),
      status: json['status'],
      proofImagePath: json['proofImagePath'],
      details: json['details'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'type': TransactionType.values.indexOf(type),
      'amount': amount,
      'date': date.toIso8601String(),
      'status': status,
      'proofImagePath': proofImagePath,
      'details': details,
    };
  }
}