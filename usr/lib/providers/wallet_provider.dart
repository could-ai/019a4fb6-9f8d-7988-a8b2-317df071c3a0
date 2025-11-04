import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/user.dart';
import '../models/product.dart';
import '../models/transaction.dart';

class WalletProvider with ChangeNotifier {
  User? _user;
  List<Transaction> _transactions = [];
  double get balance => _user?.balance ?? 0;
  List<Transaction> get transactions => _transactions;
  int get activeProductsCount => _user?.activeProducts.values.fold(0, (sum, qty) => sum + qty) ?? 0;

  void setUser(User user) {
    _user = user;
    _loadTransactions();
  }

  Future<void> addTransaction(Transaction transaction) async {
    _transactions.add(transaction);
    if (transaction.type == TransactionType.deposit && transaction.status == 'validated') {
      _user!.balance += transaction.amount;
    } else if (transaction.type == TransactionType.withdrawal) {
      _user!.balance -= transaction.amount * 1.1; // 10% frais
    }
    await _saveData();
    notifyListeners();
  }

  Future<void> buyProduct(Product product) async {
    if (_user!.balance >= product.investment) {
      _user!.balance -= product.investment;
      _user!.activeProducts[product.id] = (_user!.activeProducts[product.id] ?? 0) + 1;
      await addTransaction(Transaction(
        id: DateTime.now().toString(),
        type: TransactionType.productPurchase,
        amount: product.investment,
        date: DateTime.now(),
        details: {'productId': product.id},
      ));
    }
  }

  Future<void> claimLoginBonus() async {
    final now = DateTime.now();
    if (_user!.lastLoginBonus == null || !_isSameDay(_user!.lastLoginBonus!, now)) {
      _user!.balance += 70;
      _user!.lastLoginBonus = now;
      await addTransaction(Transaction(
        id: DateTime.now().toString(),
        type: TransactionType.loginBonus,
        amount: 70,
        date: now,
      ));
    }
  }

  bool _isSameDay(DateTime d1, DateTime d2) => d1.year == d2.year && d1.month == d2.month && d1.day == d2.day;

  Future<void> _saveData() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('user', _user!.toJson().toString());
    await prefs.setStringList('transactions', _transactions.map((t) => t.toJson().toString()).toList());
  }

  Future<void> _loadTransactions() async {
    final prefs = await SharedPreferences.getInstance();
    final txns = prefs.getStringList('transactions') ?? [];
    _transactions = txns.map((t) => Transaction.fromJson({})).toList(); // Placeholder
  }
}