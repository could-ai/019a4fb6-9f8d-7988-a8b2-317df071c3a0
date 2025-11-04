import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/auth_provider.dart';
import '../providers/wallet_provider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  String _phone = '';
  String _country = 'Togo';
  String _password = '';

  final List<String> _countries = ['Togo', 'Côte d\'Ivoire', 'Mali', 'Burkina Faso', 'Bénin', 'Cameroun'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Connexion Orium Invest')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              Image.asset('assets/logo.png', height: 100),
              const Text('Orium Invest – Investissez et gagnez chaque jour !', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Numéro de téléphone'),
                onChanged: (value) => _phone = value,
                validator: (value) => value!.isEmpty ? 'Requis' : null,
              ),
              DropdownButtonFormField<String>(
                value: _country,
                items: _countries.map((c) => DropdownMenuItem(value: c, child: Text(c))).toList(),
                onChanged: (value) => setState(() => _country = value!),
                decoration: const InputDecoration(labelText: 'Pays'),
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Mot de passe'),
                obscureText: true,
                onChanged: (value) => _password = value,
                validator: (value) => value!.isEmpty ? 'Requis' : null,
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    await context.read<AuthProvider>().login(_phone, _country, _password);
                    final walletProvider = context.read<WalletProvider>();
                    walletProvider.setUser(context.read<AuthProvider>().currentUser!);
                    if (context.mounted) {
                      context.go('/home');
                    }
                  }
                },
                child: const Text('Se connecter'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}