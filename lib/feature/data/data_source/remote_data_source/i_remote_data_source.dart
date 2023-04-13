import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:test_task/core/auth_services/auth_exception.dart';
import 'package:test_task/core/auth_services/auth_response.dart';
import 'package:test_task/feature/domain/entity/products_entity.dart';

abstract class IRemoteDataSource {
  Future<UserCredential> signinWithCredential(PhoneAuthCredential credential);
  Future<UserCredential> verifyWithSmsCode({
    required String smsCode,
  });

  Future<void> signInWithPhone({
    required String phoneNumber,
    required PhoneVerificationCompleted onVerificationCompleted,
    required PhoneVerificationFailed onVerificationFailed,
  });

  Future<Either<AuthException, AuthResponse>> retrieveLinkAndSignIn();
  Future<void> sendEmailLink({required String email});
  Future<List<ProductEntity>> getProducts();
}
