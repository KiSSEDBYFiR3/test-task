import 'package:test_task/core/auth_services/auth_response.dart';
import 'package:test_task/core/auth_services/auth_exception.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:dartz/dartz.dart';
import 'package:test_task/feature/data/data_source/remote_data_source/i_remote_data_source.dart';
import 'package:test_task/feature/domain/entity/products_entity.dart';
import 'package:test_task/feature/domain/repository/i_remote_repository.dart';

class RemoteRepository implements IRemoteRepository {
  final IRemoteDataSource _remoteDataSource;
  const RemoteRepository(this._remoteDataSource);

  @override
  Future<Either<AuthException, AuthResponse>> retrieveLinkAndSignIn() async =>
      await _remoteDataSource.retrieveLinkAndSignIn();

  @override
  Future<void> sendEmailLink({required String email}) async =>
      await _remoteDataSource.sendEmailLink(email: email);

  @override
  Future<void> signInWithPhone({
    required String phoneNumber,
    required PhoneVerificationCompleted onVerificationCompleted,
    required PhoneVerificationFailed onVerificationFailed,
  }) async =>
      await _remoteDataSource.signInWithPhone(
        phoneNumber: phoneNumber,
        onVerificationCompleted: onVerificationCompleted,
        onVerificationFailed: onVerificationFailed,
      );

  @override
  Future<UserCredential> verifyWithSmsCode({required String smsCode}) async =>
      await _remoteDataSource.verifyWithSmsCode(smsCode: smsCode);

  @override
  Future<UserCredential> signinWithCredential(
          PhoneAuthCredential credential) async =>
      await _remoteDataSource.signinWithCredential(credential);

  @override
  Future<List<ProductEntity>> getProducts() async =>
      await _remoteDataSource.getProducts();
}
