import 'package:equatable/equatable.dart';

class ProductEntity extends Equatable {
  final int id;
  final String title;
  final String description;
  final int price;
  final double discountPercentage;
  final double rating;
  final int stock;
  final String brand;
  final String category;
  final String thumbnail;
  final String image;

  const ProductEntity(
      {required this.brand,
      required this.category,
      required this.description,
      required this.discountPercentage,
      required this.id,
      required this.image,
      required this.price,
      required this.rating,
      required this.stock,
      required this.thumbnail,
      required this.title});
  @override
  List<Object?> get props => [
        thumbnail,
        title,
        brand,
        category,
        description,
        discountPercentage,
        id,
        image,
        price,
        rating,
        stock
      ];
}
