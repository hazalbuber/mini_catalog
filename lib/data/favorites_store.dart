import 'package:flutter/foundation.dart';

// Ids of the products marked as favorite. Widgets listen to this notifier.
final ValueNotifier<Set<int>> favoriteIds = ValueNotifier<Set<int>>(<int>{});

// Adds the id if it is not a favorite yet, removes it otherwise.
void toggleFavorite(int id) {
  final updated = {...favoriteIds.value};
  if (!updated.remove(id)) {
    updated.add(id);
  }
  favoriteIds.value = updated;
}
