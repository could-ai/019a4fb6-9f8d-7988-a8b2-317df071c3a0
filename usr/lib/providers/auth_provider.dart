import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/user.dart';

class AuthProvider with ChangeNotifier {
  User? _currentUser;
  bool get isLoggedIn => _currentUser != null;
  User? get currentUser => _currentUser;

  Future<void> login(String phone, String country, String password) async {
    // Mock login - pour admin spécifique
    if (phone == '+228 99935673' && country == 'Togo' && password == 'AAbb11##') {
      _currentUser = User(
        id: 'admin',
        name: 'Admin',
        country: country,
        phone: phone,
        isAdmin: true,
        balance: 0, // Admin n'a pas de solde perso
      );
    } else {
      // Mock utilisateur normal - en vrai, vérifier via Supabase
      _currentUser = User(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        name: 'Utilisateur',
        country: country,
        phone: phone,
        balance: 250, // Bonus inscription
      );
    }
    await _saveUser();
    notifyListeners();
  }

  Future<void> logout() async {
    _currentUser = null;
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('user');
    notifyListeners();
  }

  Future<void> _saveUser() async {
    final prefs = await SharedPreferences.getInstance();
    if (_currentUser != null) {
      await prefs.setString('user', _currentUser!.toJson().toString());
    }
  }

  Future<void> loadUser() async {
    final prefs = await SharedPreferences.getInstance();
    final userJson = prefs.getString('user');
    if (userJson != null) {
      // Simple parse - en vrai, utiliser jsonDecode
      _currentUser = User.fromJson({}); // Placeholder
    }
  }
}