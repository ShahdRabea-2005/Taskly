abstract class AuthState {}

class AuthInitial extends AuthState {}

class AuthLoading extends AuthState {}

class AuthSuccess extends AuthState {}

class AuthError extends AuthState {
  final String message;
  AuthError(this.message);
}

class ObscurePasswordChanged extends AuthState {
  final bool isObscured;
  ObscurePasswordChanged(this.isObscured);
}
