import 'package:firebase_auth/firebase_auth.dart';
import 'package:test_task/feature/domain/repository/i_remote_repository.dart';

class SendSMSUsecase {
  final IRemoteRepository _remoteRepository;

  const SendSMSUsecase(this._remoteRepository);

  Future call({
    required String phoneNumber,
    required void Function(PhoneAuthCredential) onVerificationCompleted,
    required void Function(FirebaseAuthException) onVerificationFailed,
  }) async =>
      _remoteRepository.signInWithPhone(
        phoneNumber: phoneNumber,
        onVerificationCompleted: onVerificationCompleted,
        onVerificationFailed: onVerificationFailed,
      );
}
