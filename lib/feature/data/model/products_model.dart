import 'package:test_task/feature/domain/entity/products_entity.dart';

/// Данные получены с сайта `https://dummyjson.com/products`
/// Модель сгенерированая с помощью `https://javiercbk.github.io/json_to_dart/` и переработана в соотвествии с текщим стайлгайдом
class ProductModel extends ProductEntity {
  const ProductModel(
      {required super.id,
      required super.title,
      required super.description,
      required super.price,
      required super.discountPercentage,
      required super.rating,
      required super.stock,
      required super.brand,
      required super.category,
      required super.thumbnail,
      required super.image});

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
        id: json['id'],
        title: json['title'],
        description: json['description'],
        price: json['price'],
        discountPercentage: double.parse(json['discountPercentage'].toString()),
        rating: double.parse(json['rating'].toString()),
        stock: json['stock'],
        category: json['category'],
        thumbnail: json['thumbnail'],
        brand: json['brand'],
        image: json['images'][0] as String);
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'price': price,
      'discountPercentage': discountPercentage,
      'rating': rating,
      'stock': stock,
      'brand': brand,
      'category': category,
      'thumbnail': thumbnail,
      'image': image,
    };
  }
}
