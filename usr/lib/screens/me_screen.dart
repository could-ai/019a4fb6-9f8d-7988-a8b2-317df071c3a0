import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../providers/auth_provider.dart';
import '../providers/wallet_provider.dart';

class MeScreen extends StatelessWidget {
  const MeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final user = context.watch<AuthProvider>().currentUser;
    final walletProvider = context.watch<WalletProvider>();

    return Scaffold(
      appBar: AppBar(title: const Text('Moi')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            CircleAvatar(radius: 50, child: Text(user?.name[0] ?? 'U')),
            Text('Nom: ${user?.name}'),
            Text('Pays: ${user?.country}'),
            Text('Numéro: ${user?.phone}'),
            Text('Solde: ${walletProvider.balance} FCFA'),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(onPressed: () => context.go('/deposit'), child: const Text('Dépôt')),
                ElevatedButton(onPressed: () => context.go('/withdraw'), child: const Text('Retrait')),
                ElevatedButton(onPressed: () => _showHelpDialog(context), child: const Text('Aide')),
                ElevatedButton(onPressed: () => _showServiceDialog(context), child: const Text('Service client')),
              ],
            ),
            const SizedBox(height: 20),
            const Text('Historique des transactions', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            ListView.builder(
              shrinkWrap: true,
              itemCount: walletProvider.transactions.length,
              itemBuilder: (context, index) {
                final txn = walletProvider.transactions[index];
                return ListTile(
                  title: Text('${txn.type} - ${txn.amount} FCFA'),
                  subtitle: Text('${txn.date} - ${txn.status}'),
                );
              },
            ),
            const SizedBox(height: 20),
            ElevatedButton(onPressed: () => _showWalletDialog(context), child: const Text('Gérer portefeuille')),
            ElevatedButton(onPressed: () => _showChangePasswordDialog(context), child: const Text('Changer mot de passe')),
            ElevatedButton(onPressed: () => _showAboutDialog(context), child: const Text('À propos')),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                await context.read<AuthProvider>().logout();
                if (context.mounted) context.go('/login');
              },
              child: const Text('Déconnexion'),
            ),
          ],
        ),
      ),
    );
  }

  void _showHelpDialog(BuildContext context) {
    showDialog(context: context, builder: (context) => AlertDialog(title: const Text('Aide'), content: const Text('FAQ Q1-Q7'), actions: [TextButton(onPressed: () => Navigator.pop(context), child: const Text('Fermer'))]));
  }

  void _showServiceDialog(BuildContext context) {
    showDialog(context: context, builder: (context) => AlertDialog(title: const Text('Service client'), content: const Text('@Helios_Orium'), actions: [TextButton(onPressed: () => Navigator.pop(context), child: const Text('Fermer'))]));
  }

  void _showWalletDialog(BuildContext context) {
    // Placeholder pour création/modif/suppression portefeuille avec code secret
    showDialog(context: context, builder: (context) => AlertDialog(title: const Text('Portefeuille'), content: const Text('Fonctionnalité portefeuille (placeholder)'), actions: [TextButton(onPressed: () => Navigator.pop(context), child: const Text('Fermer'))]));
  }

  void _showChangePasswordDialog(BuildContext context) {
    showDialog(context: context, builder: (context) => AlertDialog(title: const Text('Changer mot de passe'), content: const Text('Fonctionnalité changement (placeholder)'), actions: [TextButton(onPressed: () => Navigator.pop(context), child: const Text('Fermer'))]));
  }

  void _showAboutDialog(BuildContext context) {
    showDialog(context: context, builder: (context) => AlertDialog(title: const Text('À propos'), content: const Text('Orium Invest - Île Maurice, financement participatif mines/or.'), actions: [TextButton(onPressed: () => Navigator.pop(context), child: const Text('Fermer'))]));
  }
}