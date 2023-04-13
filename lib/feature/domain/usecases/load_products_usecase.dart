import 'package:test_task/feature/domain/entity/products_entity.dart';
import 'package:test_task/feature/domain/repository/i_remote_repository.dart';

class GetProductsUsecase {
  final IRemoteRepository _remoteRepository;

  const GetProductsUsecase(this._remoteRepository);

  Future<List<ProductEntity>> call() async =>
      await _remoteRepository.getProducts();
}
