import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:repo_viewer/auth/domain/auth_failure.dart';
import 'package:repo_viewer/auth/infrastructure/github_authenticator.dart';

part 'auth_notifier.freezed.dart';

@freezed
class AuthState with _$AuthState {
  const AuthState._();
  const factory AuthState.initial() = _Initial;
  const factory AuthState.unauthenticated() = _Unauthenticated;
  const factory AuthState.authenticated() = _Authenticated;
  const factory AuthState.failure(AuthFailure failure) = _Failure;
}

class AuthNotifier extends StateNotifier<AuthState> {
  final GithubAuthenticator _githubAuthenticator;

  AuthNotifier(this._githubAuthenticator) : super(const AuthState.initial());

  Future<void> checkAndUpdateAuthStatus() async {
    if (await _githubAuthenticator.isSignedIn()) {
      state = await _githubAuthenticator.isSignedIn()
          ? const AuthState.authenticated()
          : const AuthState.unauthenticated();
    }
  }
}
