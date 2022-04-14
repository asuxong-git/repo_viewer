import 'package:oauth2/oauth2.dart';
import 'package:repo_viewer/auth/infrastructure/credentials_storage/credentials_storage.dart';

class GithubAuthenticator {
  final CredentialsStorage _credentialsStorage;

  GithubAuthenticator(this._credentialsStorage);

  Future<Credentials?> getSignedInCredentials() async {
    final storedCredentials = await _credentialsStorage.read();
    if (storedCredentials != null) {
      if (storedCredentials.canRefresh && storedCredentials.isExpired) {
        // TODO: Reffresh token
      }
    }
    return storedCredentials;
  }
}
