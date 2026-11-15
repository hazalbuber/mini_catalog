import 'package:flutter/material.dart';

import '../data/cart_store.dart';
import '../models/product.dart';
import '../theme.dart';
import '../widgets/cart_button.dart';
import '../widgets/favorite_button.dart';
import '../widgets/network_picture.dart';

class ProductDetailPage extends StatelessWidget {
  const ProductDetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Read the product that was sent with Navigator.pushNamed(... arguments: product)
    final product = ModalRoute.of(context)!.settings.arguments as Product;

    return Scaffold(
      appBar: AppBar(
        title: Text(product.name),
        actions: [
          FavoriteButton(productId: product.id),
          const CartButton(),
        ],
      ),
      body: ListView(
        children: [
          Container(
            height: 280,
            width: double.infinity,
            color: softPink,
            padding: const EdgeInsets.all(24),
            child: Hero(
              tag: 'product-${product.id}',
              child: NetworkPicture(url: product.image, iconSize: 64),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  product.name,
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  product.tagline,
                  style: const TextStyle(color: Colors.grey),
                ),
                const SizedBox(height: 12),
                Text(
                  product.price,
                  style: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w800,
                    color: brandDark,
                  ),
                ),
                const SizedBox(height: 20),
                const Text(
                  'Açıklama',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
                ),
                const SizedBox(height: 8),
                Text(product.description, style: const TextStyle(height: 1.5)),
                const SizedBox(height: 20),
                const Text(
                  'Özellikler',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
                ),
                const SizedBox(height: 8),
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: product.specs.entries
                      .map(
                        (entry) =>
                            Chip(label: Text('${entry.key}: ${entry.value}')),
                      )
                      .toList(),
                ),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: FilledButton.icon(
            onPressed: () {
              addToCart(product);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('${product.name} sepete eklendi'),
                  duration: const Duration(seconds: 1),
                ),
              );
            },
            icon: const Icon(Icons.add_shopping_cart),
            label: const Text('Sepete Ekle'),
            style: FilledButton.styleFrom(
              minimumSize: const Size.fromHeight(52),
            ),
          ),
        ),
      ),
    );
  }
}
