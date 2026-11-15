import 'package:flutter/material.dart';

import 'pages/cart_page.dart';
import 'pages/home_page.dart';
import 'pages/product_detail_page.dart';
import 'theme.dart';

void main() {
  runApp(const MiniCatalogApp());
}

class MiniCatalogApp extends StatelessWidget {
  const MiniCatalogApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Lotus Store',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: brandRed)
            .copyWith(primary: brandRed, onPrimary: Colors.white),
        scaffoldBackgroundColor: Colors.white,
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.white,
          surfaceTintColor: Colors.transparent,
          elevation: 0,
        ),
      ),
      // Named routes: each page has a name that Navigator.pushNamed can use.
      initialRoute: '/',
      routes: {
        '/': (context) => const HomePage(),
        '/detail': (context) => const ProductDetailPage(),
        '/cart': (context) => const CartPage(),
      },
    );
  }
}
