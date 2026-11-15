import 'package:flutter/material.dart';

import '../data/favorites_store.dart';
import '../theme.dart';

// Heart button: filled when the product is a favorite.
class FavoriteButton extends StatelessWidget {
  const FavoriteButton({super.key, required this.productId, this.size = 24});

  final int productId;
  final double size;

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<Set<int>>(
      valueListenable: favoriteIds,
      builder: (context, favorites, _) {
        final isFavorite = favorites.contains(productId);
        return IconButton(
          tooltip: isFavorite ? 'Favorilerden çıkar' : 'Favorilere ekle',
          visualDensity: VisualDensity.compact,
          iconSize: size,
          icon: Icon(
            isFavorite ? Icons.favorite : Icons.favorite_border,
            color: brandRed,
          ),
          onPressed: () => toggleFavorite(productId),
        );
      },
    );
  }
}
