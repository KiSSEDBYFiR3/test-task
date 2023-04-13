import 'package:equatable/equatable.dart';
import 'package:test_task/feature/domain/entity/products_entity.dart';

abstract class MainCubitState extends Equatable {
  const MainCubitState();

  @override
  List<Object?> get props => [];
}

class InitialState extends MainCubitState {}

class MainCubitLoadingDataState extends MainCubitState {}

class MainCubitErrorState extends MainCubitState {
  final String message;

  const MainCubitErrorState(this.message);
}

class MainCubitLoadedState extends MainCubitState {
  final List<ProductEntity> products;

  const MainCubitLoadedState(this.products);

  @override
  List<Object?> get props => [products];
}
