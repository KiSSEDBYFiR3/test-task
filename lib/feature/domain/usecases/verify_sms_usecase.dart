import 'package:firebase_auth/firebase_auth.dart';
import 'package:test_task/feature/domain/repository/i_remote_repository.dart';

class VerifySMSUsecase {
  final IRemoteRepository _remoteRepository;

  VerifySMSUsecase(this._remoteRepository);

  Future<UserCredential> call(String smsCode) async =>
      await _remoteRepository.verifyWithSmsCode(smsCode: smsCode);
}
