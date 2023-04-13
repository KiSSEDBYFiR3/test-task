import 'package:firebase_auth/firebase_auth.dart';
import 'package:test_task/feature/domain/repository/i_remote_repository.dart';

class SignInWithCredentialUsecase {
  final IRemoteRepository _remoteRepository;

  SignInWithCredentialUsecase(this._remoteRepository);

  Future<UserCredential> call(PhoneAuthCredential credential) async =>
      await _remoteRepository.signinWithCredential(credential);
}
