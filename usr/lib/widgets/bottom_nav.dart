import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class BottomNav extends StatelessWidget {
  final int currentIndex;
  const BottomNav({super.key, required this.currentIndex});

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: currentIndex,
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
    );
  }
}