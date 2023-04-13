import 'package:dartz/dartz.dart';
import 'package:test_task/core/auth_services/auth_exception.dart';
import 'package:test_task/core/auth_services/auth_response.dart';
import 'package:test_task/feature/domain/repository/i_remote_repository.dart';

class AuthenticateByDynamicLinkUsecase {
  final IRemoteRepository _remoteRepository;

  const AuthenticateByDynamicLinkUsecase(this._remoteRepository);

  Future<Either<AuthException, AuthResponse>> call() async =>
      _remoteRepository.retrieveLinkAndSignIn();
}
