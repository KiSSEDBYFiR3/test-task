import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_task/core/auth_services/auth_response.dart';
import 'package:test_task/feature/domain/usecases/authenticate_by_biometrics_usecase.dart';
import 'package:test_task/feature/domain/usecases/authenticate_by_dynamic_link_usecase.dart';
import 'package:test_task/feature/domain/usecases/send_email_link_usecase.dart';
import 'package:test_task/feature/domain/usecases/send_sms_usecase.dart';
import 'package:test_task/feature/domain/usecases/sign_in_with_credential_usecase.dart';
import 'package:test_task/feature/domain/usecases/verify_sms_usecase.dart';
import 'package:test_task/feature/presentation/cubits/auth_cubit/auth_cubit_states.dart';
import 'dart:developer' as developer;

class AuthCubit extends Cubit<AuthCubitState> {
  AuthenticateByBiometricsUsecase authenticateByBiometrics;
  AuthenticateByDynamicLinkUsecase authenticateByDynamicLink;
  SignInWithCredentialUsecase signInWithCredential;
  SendEmailLinkUsecase sendEmailLink;
  SendSMSUsecase sendSMS;
  VerifySMSUsecase verifySMS;

  AuthCubit(
      {required this.authenticateByBiometrics,
      required this.authenticateByDynamicLink,
      required this.sendEmailLink,
      required this.sendSMS,
      required this.verifySMS,
      required this.signInWithCredential})
      : super(InitState());

  Future<void> sendEmail(String email) async {
    await sendEmailLink.call(email);
    emit(AuthenticatingState());
    developer.log(state.toString());
  }

  Future<void> authenticateByDynamicLinkCredential() async {
    final authResponse = await authenticateByDynamicLink.call();
    developer.log(authResponse.toString());
    if (authResponse is AuthResponse) {
      emit(AuthenticatedState());
      developer.log(state.toString());
    } else {
      developer.log(state.toString());
      emit(const AuthenticationErrorState(
          "Ошибка авторизации!\nПопробуйте еще раз или воспользуйтесь другим методом!"));
    }
  }

  Future<void> authByBiometrics() async {
    emit(AuthenticatingState());
    await authenticateByBiometrics.call().then((value) {
      if (value) {
        emit(AuthenticatedState());
      } else {
        emit(const AuthenticationErrorState(
            "Ошибка входа данным методом!\nПроверьте настройки безопасности вашего устройства или воспользуйтесь другим методом!"));
      }
    });
  }

  Future<void> sendSMSCode({
    required String phoneNumber,
  }) async {
    emit(AuthenticatingState());
    await sendSMS.call(
      phoneNumber: phoneNumber,
      onVerificationCompleted: (signInCredential) {},
      onVerificationFailed: (message) {
        emit(AuthenticationErrorState(message.toString()));
      },
    );
  }

  Future<void> verifySMSCode(String sms) async {
    try {
      final user = await verifySMS.call(sms);
      if (user.user != null) {
        emit(AuthenticatedState());
      } else {
        emit(const AuthenticationErrorState("Ошибка авторизации!"));
      }
    } on Exception catch (message) {
      developer.log(message.toString());
      emit(AuthenticationErrorState(message.toString()));
    }
  }
}
