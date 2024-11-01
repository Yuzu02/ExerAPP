// /lib/models/exercise/product.dart
class Product {
  final int? id;
  final String code;
  final String description;
  final double price;

  Product({
    this.id,
    required this.code,
    required this.description,
    required this.price,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'code': code,
      'description': description,
      'price': price,
    };
  }

  factory Product.fromMap(Map<String, dynamic> map) {
    return Product(
      id: map['id'],
      code: map['code'],
      description: map['description'],
      price: map['price'],
    );
  }
}
