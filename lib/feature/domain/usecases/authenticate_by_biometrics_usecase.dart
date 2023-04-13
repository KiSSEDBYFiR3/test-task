import 'package:test_task/feature/domain/repository/i_local_repository.dart';

class AuthenticateByBiometricsUsecase {
  final ILocalRepository _localRepository;

  const AuthenticateByBiometricsUsecase(this._localRepository);

  Future<bool> call() async => await _localRepository.authenticate();
}
