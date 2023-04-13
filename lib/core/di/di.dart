import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:local_auth/local_auth.dart';
import 'package:test_task/core/navigation/app_router.dart';
import 'package:test_task/feature/data/data_source/local_data_source/i_local_data_source.dart';
import 'package:test_task/feature/data/data_source/local_data_source/local_data_source.dart';
import 'package:test_task/feature/data/data_source/remote_data_source/i_remote_data_source.dart';
import 'package:test_task/feature/data/data_source/remote_data_source/remote_data_source.dart';
import 'package:test_task/feature/data/repository/local_repository.dart';
import 'package:test_task/feature/data/repository/remote_repository.dart';
import 'package:test_task/feature/domain/repository/i_local_repository.dart';
import 'package:test_task/feature/domain/repository/i_remote_repository.dart';
import 'package:test_task/feature/domain/usecases/authenticate_by_biometrics_usecase.dart';
import 'package:test_task/feature/domain/usecases/authenticate_by_dynamic_link_usecase.dart';
import 'package:test_task/feature/domain/usecases/load_products_usecase.dart';
import 'package:test_task/feature/domain/usecases/send_email_link_usecase.dart';
import 'package:test_task/feature/domain/usecases/send_sms_usecase.dart';
import 'package:test_task/feature/domain/usecases/sign_in_with_credential_usecase.dart';
import 'package:test_task/feature/domain/usecases/verify_sms_usecase.dart';
import 'package:test_task/feature/presentation/cubits/auth_cubit/auth_cubit.dart';
import 'package:test_task/feature/presentation/cubits/main_cubit/main_cubit.dart';
import 'package:test_task/main.dart';

/// Глобальная [instance] контейнера
final IDiContainer diContainer = DiContainer();

/// Абстракция контейнера, для того, чтобы в будующем можно было заменить его другим, если возникнет нужда
abstract class IDiContainer {
  MyApp createMyApp();
  AuthCubit createAuthCubit();
  MainCubit createMainCubit();
}

/// Контейнер для внедрения зависимостей
class DiContainer implements IDiContainer {
  @override
  MyApp createMyApp() => MyApp(
        appRouter: _createAppRouter(),
      );
  @override
  AuthCubit createAuthCubit() => AuthCubit(
      authenticateByBiometrics: _createAuthenticateByBiometrics(),
      authenticateByDynamicLink: _createAuthenticateByDynamicLink(),
      sendEmailLink: _createSendEmailLink(),
      sendSMS: _createSendSMS(),
      verifySMS: _createVerifySMS(),
      signInWithCredential: _createSignInWithCredential());
  @override
  MainCubit createMainCubit() => MainCubit(_createGetProducts());
  AppRouter _createAppRouter() => AppRouter();
  AuthenticateByDynamicLinkUsecase _createAuthenticateByDynamicLink() =>
      AuthenticateByDynamicLinkUsecase(_createRemoteRepository());
  SendEmailLinkUsecase _createSendEmailLink() =>
      SendEmailLinkUsecase(_createRemoteRepository());
  SendSMSUsecase _createSendSMS() => SendSMSUsecase(_createRemoteRepository());
  VerifySMSUsecase _createVerifySMS() =>
      VerifySMSUsecase(_createRemoteRepository());
  SignInWithCredentialUsecase _createSignInWithCredential() =>
      SignInWithCredentialUsecase(_createRemoteRepository());
  AuthenticateByBiometricsUsecase _createAuthenticateByBiometrics() =>
      AuthenticateByBiometricsUsecase(_createLocalRepository());
  ILocalRepository _createLocalRepository() =>
      LocalRepository(_createLocalDataSource());
  IRemoteRepository _createRemoteRepository() =>
      RemoteRepository(_remoteDataSource);
  GetProductsUsecase _createGetProducts() =>
      GetProductsUsecase(_createRemoteRepository());

  /// Создаю [RemoteDataSource] синглтоном, потому что иначе получаю ошибку из-за того, что создаются разные объекты [RemoteRepository], которые имеют разные источники данных
  late final IRemoteDataSource _remoteDataSource =
      RemoteDataSource(auth: FirebaseAuth.instance, dio: _dio());

  ILocalDataSource _createLocalDataSource() =>
      LocalDataSource(_createLocalAuthentication());
  LocalAuthentication _createLocalAuthentication() => LocalAuthentication();
  Dio _dio() => Dio();
}
