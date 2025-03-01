// auth_state.dart
abstract class AuthState {
  const AuthState();
}

class AuthInitial extends AuthState {
  const AuthInitial();
}

class AuthAppLoading extends AuthState {
  const AuthAppLoading();
}

class AuthOperationLoading extends AuthState {
  final String operation; // Hangi işlemin yüklendiğini belirtmek için
  const AuthOperationLoading(this.operation);
}

class AuthAuthenticated extends AuthState {
  const AuthAuthenticated();
}

class AuthUnauthenticated extends AuthState {
  const AuthUnauthenticated();
}

class AuthError extends AuthState {
  final String message;
  const AuthError([this.message = "Bir hata oluştu"]);
}
