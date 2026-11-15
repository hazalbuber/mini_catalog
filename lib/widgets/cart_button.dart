import 'package:flutter/material.dart';

import '../data/cart_store.dart';
import '../models/product.dart';

// App bar button that shows how many items are in the cart.
class CartButton extends StatelessWidget {
  const CartButton({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<List<Product>>(
      valueListenable: cartItems,
      builder: (context, items, _) {
        return IconButton(
          tooltip: 'Sepet',
          icon: Badge(
            isLabelVisible: items.isNotEmpty,
            label: Text('${items.length}'),
            child: const Icon(Icons.shopping_bag_outlined),
          ),
          onPressed: () => Navigator.pushNamed(context, '/cart'),
        );
      },
    );
  }
}
