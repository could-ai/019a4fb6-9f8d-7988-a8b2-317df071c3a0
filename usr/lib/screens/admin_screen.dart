import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/auth_provider.dart';
import '../providers/wallet_provider.dart';

class AdminScreen extends StatelessWidget {
  const AdminScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final walletProvider = context.watch<WalletProvider>();
    // Mock stats/données
    final pendingDeposits = walletProvider.transactions.where((t) => t.type == TransactionType.deposit && t.status == 'pending').length;
    final validatedDeposits = walletProvider.transactions.where((t) => t.type == TransactionType.deposit && t.status == 'validated').length;
    final pendingWithdrawals = walletProvider.transactions.where((t) => t.type == TransactionType.withdrawal && t.status == 'pending').length;
    final validatedWithdrawals = walletProvider.transactions.where((t) => t.type == TransactionType.withdrawal && t.status == 'validated').length;

    return Scaffold(
      appBar: AppBar(title: const Text('Admin Orium Invest')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const Text('Statistiques globales', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            Text('Dépôts en attente: $pendingDeposits'),
            Text('Dépôts validés: $validatedDeposits'),
            Text('Retraits en attente: $pendingWithdrawals'),
            Text('Retraits validés: $validatedWithdrawals'),
            const SizedBox(height: 20),
            const Text('Gestion utilisateurs', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            // Placeholder liste utilisateurs
            Expanded(
              child: ListView.builder(
                itemCount: 1, // Mock
                itemBuilder: (context, index) => ListTile(
                  title: const Text('Utilisateur Mock'),
                  subtitle: const Text('Solde: 0 FCFA, Filleuls: 0, Produits: 0, Pays: Togo'),
                  trailing: ElevatedButton(
                    onPressed: () => _showUserDetailsDialog(context),
                    child: const Text('Détails'),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => _showUpdatePaymentLinkDialog(context),
              child: const Text('Modifier lien paiement'),
            ),
          ],
        ),
      ),
    );
  }

  void _showUserDetailsDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Détails utilisateur'),
        content: const Text('Attribution/retrait produits (placeholder)'),
        actions: [TextButton(onPressed: () => Navigator.pop(context), child: const Text('Fermer'))],
      ),
    );
  }

  void _showUpdatePaymentLinkDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Modifier lien paiement'),
        content: TextField(decoration: const InputDecoration(labelText: 'Nouveau lien'), onChanged: (value) => {}),
        actions: [TextButton(onPressed: () => Navigator.pop(context), child: const Text('Mettre à jour'))],
      ),
    );
  }
}