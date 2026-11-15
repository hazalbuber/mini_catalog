// Product model: one item of the "data" list in assets/products.json
class Product {
  final int id;
  final String name;
  final String tagline;
  final String description;
  final String price; // e.g. "$999"
  final String currency;
  final String
  image; // image URL, e.g. https://wantapi.com/assets/images/iphone.png
  final Map<String, String> specs;

  const Product({
    required this.id,
    required this.name,
    required this.tagline,
    required this.description,
    required this.price,
    required this.currency,
    required this.image,
    required this.specs,
  });

  // JSON -> Product
  factory Product.fromJson(Map<String, dynamic> json) {
    final rawSpecs = (json['specs'] as Map<String, dynamic>?) ?? {};
    return Product(
      id: json['id'] as int,
      name: json['name'] as String,
      tagline: (json['tagline'] as String?) ?? '',
      description: (json['description'] as String?) ?? '',
      price: (json['price'] as String?) ?? '',
      currency: (json['currency'] as String?) ?? '',
      image: (json['image'] as String?) ?? '',
      specs: rawSpecs.map((key, value) => MapEntry(key, value.toString())),
    );
  }

  // Product -> JSON
  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'tagline': tagline,
    'description': description,
    'price': price,
    'currency': currency,
    'image': image,
    'specs': specs,
  };

  // Numeric price, used for the cart total ("$1,299" -> 1299.0)
  double get priceValue =>
      double.tryParse(price.replaceAll(RegExp(r'[^0-9.]'), '')) ?? 0;
}
