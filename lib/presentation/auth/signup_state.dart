part of 'signup_cubit.dart';

abstract class SignupState {}

class SignupInitial extends SignupState {}

class SignupLoading extends SignupState {}

class SignupSuccess extends SignupState {}

class SignupError extends SignupState {
  final String message;
  SignupError(this.message);
}

class SignupPasswordVisibilityChanged extends SignupState {
  final bool isObscure;
  SignupPasswordVisibilityChanged(this.isObscure);
}

class SignupTermsChanged extends SignupState {
  final bool isAgreed;
  SignupTermsChanged(this.isAgreed);
}