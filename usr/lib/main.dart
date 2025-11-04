import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'providers/auth_provider.dart';
import 'providers/wallet_provider.dart';
import 'screens/login_screen.dart';
import 'screens/home_screen.dart';
import 'screens/products_screen.dart';
import 'screens/mine_screen.dart';
import 'screens/team_screen.dart';
import 'screens/me_screen.dart';
import 'screens/admin_screen.dart';
import 'screens/deposit_screen.dart';
import 'screens/withdraw_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthProvider()),
        ChangeNotifierProvider(create: (_) => WalletProvider()),
      ],
      child: const OriumInvestApp(),
    ),
  );
}

class OriumInvestApp extends StatelessWidget {
  const OriumInvestApp({super.key});

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);

    final router = GoRouter(
      initialLocation: authProvider.isLoggedIn ? '/home' : '/login',
      routes: [
        GoRoute(path: '/login', builder: (context, state) => const LoginScreen()),
        GoRoute(path: '/home', builder: (context, state) => const HomeScreen()),
        GoRoute(path: '/products', builder: (context, state) => const ProductsScreen()),
        GoRoute(path: '/mine', builder: (context, state) => const MineScreen()),
        GoRoute(path: '/team', builder: (context, state) => const TeamScreen()),
        GoRoute(path: '/me', builder: (context, state) => const MeScreen()),
        GoRoute(path: '/admin', builder: (context, state) => const AdminScreen()),
        GoRoute(path: '/deposit', builder: (context, state) => const DepositScreen()),
        GoRoute(path: '/withdraw', builder: (context, state) => const WithdrawScreen()),
      ],
    );

    return MaterialApp.router(
      title: 'Orium Invest – Investissez et gagnez chaque jour !',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.amber, // Couleur dorée pour thème mines/or
          brightness: Brightness.light,
        ),
        useMaterial3: true,
        fontFamily: 'Roboto',
      ),
      routerConfig: router,
    );
  }
}