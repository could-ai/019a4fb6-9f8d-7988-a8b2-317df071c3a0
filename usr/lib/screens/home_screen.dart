import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../providers/wallet_provider.dart';
import '../widgets/banner_carousel.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final walletProvider = context.watch<WalletProvider>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Orium Invest'),
        actions: [
          IconButton(icon: const Icon(Icons.logout), onPressed: () => context.go('/login')),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const BannerCarousel(),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(onPressed: () => context.go('/deposit'), child: const Text('Recharger')),
                ElevatedButton(onPressed: () => context.go('/withdraw'), child: const Text('Retrait')),
                ElevatedButton(onPressed: () => _showHelpDialog(context), child: const Text('Aide')),
                ElevatedButton(onPressed: () => context.go('/mine'), child: const Text('Mine')),
              ],
            ),
            const SizedBox(height: 20),
            Text('Solde actuel: ${walletProvider.balance} FCFA', style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            Text('Revenus accumulés: ${_calculateTotalRevenue(walletProvider)} FCFA'),
            Text('Produits activés: ${walletProvider.activeProductsCount}'),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 0,
        onTap: (index) {
          switch (index) {
            case 0: context.go('/home');
            case 1: context.go('/products');
            case 2: context.go('/mine');
            case 3: context.go('/team');
            case 4: context.go('/me');
          }
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Accueil'),
          BottomNavigationBarItem(icon: Icon(Icons.shopping_cart), label: 'Produits'),
          BottomNavigationBarItem(icon: Icon(Icons.diamond), label: 'Mine'),
          BottomNavigationBarItem(icon: Icon(Icons.group), label: 'Équipe'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Moi'),
        ],
      ),
    );
  }

  double _calculateTotalRevenue(WalletProvider provider) {
    // Simulation basée sur transactions validées
    return provider.transactions.where((t) => t.status == 'validated').fold(0.0, (sum, t) => sum + t.amount);
  }

  void _showHelpDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Aide'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text('Chaîne Telegram: https://t.me/+ZdfwlOppcA40MzVk'),
            const Text('Service client: @Helios_Orium'),
            const Text('FAQ: Q1-Q7 (placeholder)'),
          ],
        ),
        actions: [TextButton(onPressed: () => Navigator.pop(context), child: const Text('Fermer'))],
      ),
    );
  }
}