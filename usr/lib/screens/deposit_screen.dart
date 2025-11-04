import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import '../providers/wallet_provider.dart';
import '../models/transaction.dart';

class DepositScreen extends StatefulWidget {
  const DepositScreen({super.key});

  @override
  State<DepositScreen> createState() => _DepositScreenState();
}

class _DepositScreenState extends State<DepositScreen> {
  double _amount = 0;
  String _selectedPreset = '';
  String _fullName = '';
  String _country = 'Togo';
  String _paymentMethod = '';
  String _accountNumber = '';
  String? _proofImagePath;

  final List<String> _presets = ['3000', '5000', '20000', '50000'];
  final List<String> _countries = ['Togo', 'Côte d\'Ivoire', 'Mali', 'Burkina Faso', 'Bénin', 'Cameroun'];
  final Map<String, List<String>> _paymentMethods = {
    'Togo': ['Moov Money', 'Mixx by Yas'],
    // Autres pays...
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Dépôt')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const Text('Procédure de dépôt détaillée...', style: TextStyle(fontSize: 16)),
            const SizedBox(height: 20),
            TextField(
              decoration: const InputDecoration(labelText: 'Montant (FCFA)'),
              keyboardType: TextInputType.number,
              onChanged: (value) => _amount = double.tryParse(value) ?? 0,
            ),
            Wrap(
              children: _presets.map((p) => ElevatedButton(
                onPressed: () => setState(() => _amount = double.parse(p)),
                child: Text('$p F'),
              )).toList(),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => launchUrl(Uri.parse('https://www.pay.moneyfusion.net/paiement-de-la-formation-orium_1762192734005/')),
              child: const Text('Terminer le paiement'),
            ),
            const SizedBox(height: 40),
            const Text('Soumettre preuve de paiement', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            TextField(decoration: const InputDecoration(labelText: 'Nom complet'), onChanged: (value) => _fullName = value),
            DropdownButtonFormField<String>(
              value: _country,
              items: _countries.map((c) => DropdownMenuItem(value: c, child: Text(c))).toList(),
              onChanged: (value) => setState(() => _country = value!),
            ),
            DropdownButtonFormField<String>(
              value: _paymentMethod,
              items: (_paymentMethods[_country] ?? []).map((m) => DropdownMenuItem(value: m, child: Text(m))).toList(),
              onChanged: (value) => setState(() => _paymentMethod = value!),
            ),
            TextField(decoration: const InputDecoration(labelText: 'Numéro de paiement'), onChanged: (value) => _accountNumber = value),
            ElevatedButton(
              onPressed: () async {
                final picker = ImagePicker();
                final image = await picker.pickImage(source: ImageSource.gallery);
                if (image != null) setState(() => _proofImagePath = image.path);
              },
              child: const Text('Sélectionner capture'),
            ),
            if (_proofImagePath != null) Text('Image sélectionnée: $_proofImagePath'),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                final txn = Transaction(
                  id: DateTime.now().toString(),
                  type: TransactionType.deposit,
                  amount: _amount,
                  date: DateTime.now(),
                  proofImagePath: _proofImagePath,
                  details: {'fullName': _fullName, 'country': _country, 'method': _paymentMethod, 'account': _accountNumber},
                );
                await context.read<WalletProvider>().addTransaction(txn);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Preuve soumise pour validation !')),
                );
              },
              child: const Text('Soumettre la preuve'),
            ),
          ],
        ),
      ),
    );
  }
}