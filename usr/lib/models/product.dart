class Product {
  String id;
  String name;
  double investment;
  double dailyGain;
  int durationDays;
  double totalGain;

  Product({
    required this.id,
    required this.name,
    required this.investment,
    required this.dailyGain,
    required this.durationDays,
  }) : totalGain = dailyGain * durationDays;

  // Calcul gain cumulatif basé sur jours écoulés (simulation)
  double calculateCumulativeGain(int daysElapsed) {
    return dailyGain * daysElapsed.clamp(0, durationDays);
  }

  static List<Product> getAllProducts() {
    return [
      Product(id: '1', name: 'Orium 1', investment: 3000, dailyGain: 360, durationDays: 90),
      Product(id: '2', name: 'Orium 2', investment: 5000, dailyGain: 600, durationDays: 90),
      Product(id: '3', name: 'Orium 3', investment: 10000, dailyGain: 1050, durationDays: 90),
      Product(id: '4', name: 'Orium 4', investment: 15000, dailyGain: 1300, durationDays: 90),
      Product(id: '5', name: 'Orium 5', investment: 20000, dailyGain: 2100, durationDays: 90),
      Product(id: '6', name: 'Orium 6', investment: 30000, dailyGain: 3200, durationDays: 90),
      Product(id: '7', name: 'Orium 7', investment: 50000, dailyGain: 5500, durationDays: 90),
      Product(id: '8', name: 'Orium 8', investment: 100000, dailyGain: 11000, durationDays: 90),
    ];
  }
}