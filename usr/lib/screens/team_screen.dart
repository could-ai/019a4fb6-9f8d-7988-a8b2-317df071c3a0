import 'package:flutter/material.dart';

class TeamScreen extends StatelessWidget {
  const TeamScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Mock données parrainage
    final referrals = ['Filleul1', 'Filleul2'];

    return Scaffold(
      appBar: AppBar(title: const Text('Équipe')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const Text('Système de parrainage à 3 niveaux', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const Text('Niveau 1: 25%'),
            const Text('Niveau 2: 3%'),
            const Text('Niveau 3: 2%'),
            const SizedBox(height: 20),
            Text('Nombre de filleuls: ${referrals.length}'),
            // Stats détaillées placeholder
            const Text('Statistiques: Gains parrainage total: 0 FCFA'),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Lien copié: https://nomdudomaine/login?reg=codeparrainage')),
              ),
              child: const Text('Copier lien/code'),
            ),
          ],
        ),
      ),
    );
  }
}