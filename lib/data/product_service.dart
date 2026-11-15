import 'dart:convert';

import 'package:flutter/services.dart' show rootBundle;

import '../models/product.dart';

// Reads assets/products.json and turns it into a list of Product objects.
Future<List<Product>> loadProducts() async {
  final raw = await rootBundle.loadString('assets/products.json');
  final decoded = jsonDecode(raw) as Map<String, dynamic>;
  final items = decoded['data'] as List<dynamic>;
  return items
      .map((item) => Product.fromJson(item as Map<String, dynamic>))
      .toList();
}
