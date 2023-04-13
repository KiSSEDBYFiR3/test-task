import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_task/feature/domain/usecases/load_products_usecase.dart';
import 'package:test_task/feature/presentation/cubits/main_cubit/main_cubit_states.dart';
import 'dart:developer' as developer;

class MainCubit extends Cubit<MainCubitState> {
  final GetProductsUsecase _getProductsUsecase;
  MainCubit(this._getProductsUsecase) : super(InitialState());

  Future<void> getProducts() async {
    emit(MainCubitLoadingDataState());
    try {
      final products = await _getProductsUsecase.call();
      emit(MainCubitLoadedState(products));
    } on Exception catch (e) {
      emit(MainCubitErrorState(e.toString()));
      developer.log(e.toString());
    }
  }
}
