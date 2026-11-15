import 'package:flutter/material.dart';

import '../data/favorites_store.dart';
import '../data/product_service.dart';
import '../models/product.dart';
import '../theme.dart';
import '../widgets/cart_button.dart';
import '../widgets/product_card.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late final Future<List<Product>> _productsFuture;
  String _query = '';
  bool _onlyFavorites = false;

  @override
  void initState() {
    super.initState();
    // Load the JSON only once, when the page is created.
    _productsFuture = loadProducts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Lotus Store',
          style: TextStyle(fontWeight: FontWeight.w800, color: brandRed),
        ),
        actions: const [CartButton()],
      ),
      body: FutureBuilder<List<Product>>(
        future: _productsFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState != ConnectionState.done) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(
              child: Text('Veriler yüklenemedi: ${snapshot.error}'),
            );
          }

          // Rebuild the list whenever a favorite changes.
          return ValueListenableBuilder<Set<int>>(
            valueListenable: favoriteIds,
            builder: (context, favorites, _) {
              // Simple search on name and tagline, plus the favorites filter.
              final query = _query.trim().toLowerCase();
              final products = snapshot.data!.where((product) {
                final matchesQuery =
                    product.name.toLowerCase().contains(query) ||
                    product.tagline.toLowerCase().contains(query);
                final matchesFavorite =
                    !_onlyFavorites || favorites.contains(product.id);
                return matchesQuery && matchesFavorite;
              }).toList();

              final emptyText = _onlyFavorites && favorites.isEmpty
                  ? 'Henüz favori ürün yok. Kartlardaki kalbe basarak ekle.'
                  : 'Ürün bulunamadı.';

              return ListView(
                padding: const EdgeInsets.all(16),
                children: [
                  TextField(
                    onChanged: (value) => setState(() => _query = value),
                    decoration: InputDecoration(
                      hintText: 'Ürün ara...',
                      prefixIcon: const Icon(Icons.search),
                      filled: true,
                      fillColor: softPink,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: FilterChip(
                      avatar: const Icon(
                        Icons.favorite,
                        size: 18,
                        color: brandRed,
                      ),
                      label: Text('Favoriler (${favorites.length})'),
                      selected: _onlyFavorites,
                      showCheckmark: false,
                      selectedColor: const Color(0xFFFFE3E3),
                      checkmarkColor: brandRed,
                      onSelected: (value) =>
                          setState(() => _onlyFavorites = value),
                    ),
                  ),
                  const SizedBox(height: 12),
                  // Banner drawn with code (no image needed)
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      gradient: const LinearGradient(
                        colors: [brandDark, Color(0xFFE03131)],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                    ),
                    child: const Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Yeni Ürünler',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 22,
                                  fontWeight: FontWeight.w800,
                                ),
                              ),
                              SizedBox(height: 4),
                              Text(
                                'Favori cihazlarını keşfet',
                                style: TextStyle(color: Colors.white70),
                              ),
                            ],
                          ),
                        ),
                        Icon(Icons.devices, color: Colors.white54, size: 48),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),
                  if (products.isEmpty)
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 48),
                      child: Center(child: Text(emptyText)),
                    )
                  else
                    GridView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: products.length,
                      gridDelegate:
                          const SliverGridDelegateWithMaxCrossAxisExtent(
                            maxCrossAxisExtent: 240,
                            mainAxisSpacing: 12,
                            crossAxisSpacing: 12,
                            childAspectRatio: 0.75,
                          ),
                      itemBuilder: (context, index) {
                        final product = products[index];
                        return ProductCard(
                          key: ValueKey(product.id),
                          product: product,
                          // Pass the product to the detail page as a route argument.
                          onTap: () => Navigator.pushNamed(
                            context,
                            '/detail',
                            arguments: product,
                          ),
                        );
                      },
                    ),
                ],
              );
            },
          );
        },
      ),
    );
  }
}
