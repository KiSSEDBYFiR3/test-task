import 'package:equatable/equatable.dart';

class CartItemEntity extends Equatable {
  final int id;
  final String image;
  final String price;
  final String title;

  const CartItemEntity(
      {required this.id,
      required this.image,
      required this.price,
      required this.title});

  @override
  List<Object?> get props => [title, price, image, id];
}
