import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:test_task/core/auth_services/auth_exception.dart';
import 'package:test_task/core/auth_services/auth_response.dart';
import 'package:test_task/feature/data/data_source/remote_data_source/i_remote_data_source.dart';
import 'package:test_task/feature/data/model/products_model.dart';
import 'dart:developer' as developer;

import 'package:test_task/feature/domain/entity/products_entity.dart';

const address = 'https://dummyjson.com/products';

class RemoteDataSource implements IRemoteDataSource {
  final FirebaseAuth auth;
  final Dio dio;
  String _verificationId;

  RemoteDataSource({required this.auth, required this.dio})
      : _verificationId = '';

  @override
  Future<void> sendEmailLink({required String email}) async {
    final actionCodeSettings = ActionCodeSettings(
        url: "https://fittintest.page.link/Tbeh?email=$email",
        androidPackageName: "com.example.test_task",
        handleCodeInApp: true);

    try {
      await auth.sendSignInLinkToEmail(
          email: email, actionCodeSettings: actionCodeSettings);
    } on Exception catch (e) {
      developer.log(e.toString());
      AuthException(message: e.toString());
    }
  }

  @override
  Future<Either<AuthException, AuthResponse>> retrieveLinkAndSignIn() async {
    final PendingDynamicLinkData? pendingDynamicLinkData;
    final Uri? emailLink;
    final String continueUrl;
    final String email;

    try {
      pendingDynamicLinkData = await FirebaseDynamicLinks.instance.onLink.first;

      /// Объявляем [emailLink]

      emailLink = pendingDynamicLinkData.link;

      /// Проверяем валидность ссылки
      /// Если ссылка валидна, то инициализируем [continueUrl] и [email]
      /// Если не валидна, то возвращаем [Exception]

      final bool isValid =
          auth.isSignInWithEmailLink(pendingDynamicLinkData.link.toString());

      if (isValid) {
        continueUrl =
            pendingDynamicLinkData.link.queryParameters['continueUrl'] ?? '';
        email = Uri.parse(continueUrl).queryParameters['email'] ?? '';
      } else {
        developer.log("Exception: invalid dynamic link!");
        return Left(AuthException(
            message:
                "Ошибка авторизации!\nПопробуйте еще раз или воспользуйтесь другим методом!"));
      }

      /// Пробуем авторизоваться в Firebase и затем проверяем, что [UserCredential.user] != null
      /// Если проходит проверку, возвращем [AuthResponse.success] и записываем в [GetStorage], что мы аутентифицированы
      /// Если не проходит, то возвращаем [AuthException]

      final UserCredential userCredential = await auth.signInWithEmailLink(
        email: email,
        emailLink: emailLink.toString(),
      );

      if (userCredential.user != null) {
        return const Right(AuthResponse.success);
      } else {
        developer.log("Exception: userCredential is ${userCredential.user}");
        return Left(AuthException(
            message:
                "Ошибка авторизации!\nПопробуйте еще раз или воспользуйтесь другим методом!"));
      }
    } on Exception catch (e) {
      developer.log(e.toString());
      return Left(AuthException(
          message:
              "Ошибка авторизации!\nПопробуйте еще раз или воспользуйтесь другим методом!"));
    }
  }

  /// Блок авторизации через номер телефона
  /// Хотел тоже сделать через [Either], но при авторизации через телефон меньше мест, где что-то может пойти не так, поэтому решил хэндлить ошибки внутри [AuthCubit]
  @override
  Future<void> signInWithPhone({
    required String phoneNumber,
    required PhoneVerificationCompleted onVerificationCompleted,
    required PhoneVerificationFailed onVerificationFailed,
  }) async {
    await auth.verifyPhoneNumber(
        phoneNumber: phoneNumber,
        verificationCompleted: onVerificationCompleted,
        verificationFailed: onVerificationFailed,
        codeSent: ((verificationId, forceResendingToken) async {
          _verificationId = verificationId;
        }),
        codeAutoRetrievalTimeout: (verificationId) {});
  }

  @override
  Future<UserCredential> verifyWithSmsCode({
    required String smsCode,
  }) async {
    var credential = PhoneAuthProvider.credential(
      verificationId: _verificationId,
      smsCode: smsCode,
    );

    return signinWithCredential(credential);
  }

  @override
  Future<UserCredential> signinWithCredential(
      PhoneAuthCredential credential) async {
    final user = await auth.signInWithCredential(credential);
    return user;
  }

  @override
  Future<List<ProductEntity>> getProducts() async {
    final response = await dio.get(address);
    final json = jsonDecode(response.toString());
    final List<ProductEntity> products = [];
    json['products'].forEach((i) => products.add(ProductModel.fromJson(i)));
    return products;
  }
}
