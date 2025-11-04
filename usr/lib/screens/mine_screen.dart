import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';
import '../providers/wallet_provider.dart';

class MineScreen extends StatelessWidget {
  const MineScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final walletProvider = context.read<WalletProvider>();

    return Scaffold(
      appBar: AppBar(title: const Text('Mine')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Card(
              child: ListTile(
                title: const Text('Mission de connexion quotidienne'),
                subtitle: const Text('70 FCFA crédités'),
                trailing: ElevatedButton(
                  onPressed: () async {
                    await walletProvider.claimLoginBonus();
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Bonus réclamé !')),
                    );
                  },
                  child: const Text('Recevoir ma mission'),
                ),
              ),
            ),
            const SizedBox(height: 20),
            TextField(
              decoration: const InputDecoration(labelText: 'Entrer code bonus officiel'),
              onSubmitted: (code) {
                // Mock bonus
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Bonus appliqué !')),
                );
              },
            ),
            ElevatedButton(
              onPressed: () => launchUrl(Uri.parse('https://t.me/+ZdfwlOppcA40MzVk')),
              child: const Text('Aller sur Telegram'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => Share.share('Rejoins Orium Invest avec mon lien: https://nomdudomaine/login?reg=codeparrainage'),
              child: const Text('Partager pour inviter'),
            ),
          ],
        ),
      ),
    );
  }
}