import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/wallet_provider.dart';
import '../models/transaction.dart';

class WithdrawScreen extends StatefulWidget {
  const WithdrawScreen({super.key});

  @override
  State<WithdrawScreen> createState() => _WithdrawScreenState();
}

class _WithdrawScreenState extends State<WithdrawScreen> {
  double _amount = 0;
  String _secretCode = '';
  bool _hasWallet = false; // Mock

  @override
  Widget build(BuildContext context) {
    final walletProvider = context.watch<WalletProvider>();
    final now = DateTime.now();
    final isBusinessHours = now.hour >= 9 && now.hour < 17 && now.weekday >= 1 && now.weekday <= 6;

    return Scaffold(
      appBar: AppBar(title: const Text('Retrait')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const Text('Conditions: Min 1200 FCFA, 1 retrait/jour, 10% frais, 9h-17h lun-sam'),
            const SizedBox(height: 20),
            if (!_hasWallet) ...[
              const Text('Créer portefeuille virtuel', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              // Champs création portefeuille
              ElevatedButton(
                onPressed: () => setState(() => _hasWallet = true),
                child: const Text('Créer portefeuille'),
              ),
            ] else ...[
              TextField(
                decoration: const InputDecoration(labelText: 'Montant'),
                keyboardType: TextInputType.number,
                onChanged: (value) => _amount = double.tryParse(value) ?? 0,
              ),
              TextField(
                decoration: const InputDecoration(labelText: 'Code secret 4 chiffres'),
                obscureText: true,
                onChanged: (value) => _secretCode = value,
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: (_amount >= 1200 && _amount <= walletProvider.balance && isBusinessHours) ? () async {
                  final txn = Transaction(
                    id: DateTime.now().toString(),
                    type: TransactionType.withdrawal,
                    amount: _amount,
                    date: DateTime.now(),
                  );
                  await walletProvider.addTransaction(txn);
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Retrait soumis ! Argent débité.')),
                  );
                } : null,
                child: const Text('Soumettre le retrait'),
              ),
            ],
          ],
        ),
      ),
    );
  }
}