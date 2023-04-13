import 'package:local_auth/local_auth.dart';
import 'package:local_auth_android/types/auth_messages_android.dart';
import 'package:local_auth_ios/local_auth_ios.dart';
import 'package:test_task/feature/data/data_source/local_data_source/i_local_data_source.dart';
import 'dart:developer' as developer;

class LocalDataSource implements ILocalDataSource {
  final LocalAuthentication _authentication;

  const LocalDataSource(this._authentication);

  @override
  Future<bool> authenticate() async {
    bool didAuthenticate = false;
    final bool canAuthenticateWithBiometrics =
        await _authentication.canCheckBiometrics;
    final bool canAuthenticate = canAuthenticateWithBiometrics ||
        await _authentication.isDeviceSupported();
    if (canAuthenticate) {
      try {
        didAuthenticate = await _authentication.authenticate(
            localizedReason: 'Авторизуйтесь, чтобы продолжить',
            authMessages: <AuthMessages>[
              const AndroidAuthMessages(
                  signInTitle: "Необходима аутентификация!",
                  biometricHint: "",
                  cancelButton: "Нет, спасибо!")
            ],
            options: const AuthenticationOptions(
                stickyAuth: false, useErrorDialogs: true, biometricOnly: true));
      } catch (e) {
        developer.log(e.toString());
      }
    }
    return didAuthenticate;
  }
}
