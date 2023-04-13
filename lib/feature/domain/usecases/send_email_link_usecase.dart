import 'package:test_task/feature/domain/repository/i_remote_repository.dart';

class SendEmailLinkUsecase {
  final IRemoteRepository _remoteRepository;

  const SendEmailLinkUsecase(this._remoteRepository);

  Future<void> call(String email) async =>
      _remoteRepository.sendEmailLink(email: email);
}
