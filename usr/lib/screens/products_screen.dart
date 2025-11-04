import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/wallet_provider.dart';
import '../models/product.dart';

class ProductsScreen extends StatelessWidget {
  const ProductsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final products = Product.getAllProducts();
    final walletProvider = context.read<WalletProvider>();

    return Scaffold(
      appBar: AppBar(title: const Text('Produits')),
      body: ListView.builder(
        itemCount: products.length,
        itemBuilder: (context, index) {
          final product = products[index];
          return Card(
            child: ListTile(
              title: Text(product.name),
              subtitle: Text('Montant: ${product.investment} FCFA\nGain/jour: ${product.dailyGain} FCFA\nTotal 90j: ${product.totalGain} FCFA'),
              trailing: ElevatedButton(
                onPressed: () async {
                  await walletProvider.buyProduct(product);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('${product.name} acheté ! Gains commencent demain.')),
                  );
                },
                child: const Text('Acheter'),
              ),
            ),
          );
        },
      ),
    );
  }
}