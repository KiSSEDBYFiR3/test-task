import 'package:test_task/feature/data/data_source/local_data_source/i_local_data_source.dart';
import 'package:test_task/feature/domain/repository/i_local_repository.dart';

class LocalRepository implements ILocalRepository {
  final ILocalDataSource _localDataSource;

  const LocalRepository(this._localDataSource);

  @override
  Future<bool> authenticate() async => await _localDataSource.authenticate();
}
