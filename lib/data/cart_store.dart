import 'package:flutter/foundation.dart';

import '../models/product.dart';

// A very simple cart: one global list that widgets can listen to.
// Whenever the list changes, every ValueListenableBuilder rebuilds automatically.
final ValueNotifier<List<Product>> cartItems = ValueNotifier<List<Product>>(
  <Product>[],
);

void addToCart(Product product) {
  cartItems.value = [...cartItems.value, product];
}

void removeFromCartAt(int index) {
  final updated = [...cartItems.value]..removeAt(index);
  cartItems.value = updated;
}

void clearCart() {
  cartItems.value = <Product>[];
}

double cartTotal(List<Product> items) {
  return items.fold<double>(0, (sum, product) => sum + product.priceValue);
}
