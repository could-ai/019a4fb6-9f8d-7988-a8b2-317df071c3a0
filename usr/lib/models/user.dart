class User {
  String id;
  String name;
  String country;
  String phone;
  double balance;
  List<String> referrals; // Filleuls parrainage
  Map<String, int> activeProducts; // Produit ID -> quantité
  Wallet? wallet;
  bool isAdmin;
  DateTime? lastLoginBonus; // Pour mission connexion

  User({
    required this.id,
    required this.name,
    required this.country,
    required this.phone,
    this.balance = 0.0,
    this.referrals = const [],
    this.activeProducts = const {},
    this.wallet,
    this.isAdmin = false,
    this.lastLoginBonus,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      name: json['name'],
      country: json['country'],
      phone: json['phone'],
      balance: json['balance'],
      referrals: List<String>.from(json['referrals']),
      activeProducts: Map<String, int>.from(json['activeProducts']),
      wallet: json['wallet'] != null ? Wallet.fromJson(json['wallet']) : null,
      isAdmin: json['isAdmin'],
      lastLoginBonus: json['lastLoginBonus'] != null ? DateTime.parse(json['lastLoginBonus']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'country': country,
      'phone': phone,
      'balance': balance,
      'referrals': referrals,
      'activeProducts': activeProducts,
      'wallet': wallet?.toJson(),
      'isAdmin': isAdmin,
      'lastLoginBonus': lastLoginBonus?.toIso8601String(),
    };
  }
}

class Wallet {
  String fullName;
  String paymentMethod;
  String accountNumber;
  String holderName;
  String secretCode; // 4 chiffres

  Wallet({
    required this.fullName,
    required this.paymentMethod,
    required this.accountNumber,
    required this.holderName,
    required this.secretCode,
  });

  factory Wallet.fromJson(Map<String, dynamic> json) {
    return Wallet(
      fullName: json['fullName'],
      paymentMethod: json['paymentMethod'],
      accountNumber: json['accountNumber'],
      holderName: json['holderName'],
      secretCode: json['secretCode'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'fullName': fullName,
      'paymentMethod': paymentMethod,
      'accountNumber': accountNumber,
      'holderName': holderName,
      'secretCode': secretCode,
    };
  }
}