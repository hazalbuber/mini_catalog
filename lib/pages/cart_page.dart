import 'package:flutter/material.dart';

import '../data/cart_store.dart';
import '../models/product.dart';
import '../widgets/network_picture.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Sepet')),
      body: ValueListenableBuilder<List<Product>>(
        valueListenable: cartItems,
        builder: (context, items, _) {
          // Empty cart screen
          if (items.isEmpty) {
            return const Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.shopping_cart_outlined,
                    size: 72,
                    color: Colors.grey,
                  ),
                  SizedBox(height: 12),
                  Text(
                    'Sepetin boş',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
                  ),
                  SizedBox(height: 4),
                  Text(
                    'Ürünleri keşfetmek için ana sayfaya dön.',
                    style: TextStyle(color: Colors.grey),
                  ),
                ],
              ),
            );
          }

          return Column(
            children: [
              Expanded(
                child: ListView.separated(
                  itemCount: items.length,
                  separatorBuilder: (context, index) =>
                      const Divider(height: 1),
                  itemBuilder: (context, index) {
                    final product = items[index];
                    return ListTile(
                      leading: SizedBox(
                        width: 56,
                        child: NetworkPicture(url: product.image),
                      ),
                      title: Text(product.name),
                      subtitle: Text(product.price),
                      trailing: IconButton(
                        tooltip: 'Sepetten çıkar',
                        icon: const Icon(Icons.remove_circle_outline),
                        onPressed: () => removeFromCartAt(index),
                      ),
                    );
                  },
                ),
              ),
              SafeArea(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text('Toplam', style: TextStyle(fontSize: 16)),
                          Text(
                            '\$${cartTotal(items).toStringAsFixed(2)}',
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      FilledButton(
                        onPressed: () {
                          clearCart();
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Sipariş alındı (simülasyon)'),
                            ),
                          );
                        },
                        style: FilledButton.styleFrom(
                          minimumSize: const Size.fromHeight(52),
                        ),
                        child: const Text('Satın Al'),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
