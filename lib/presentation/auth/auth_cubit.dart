import 'package:flutter_bloc/flutter_bloc.dart';

import 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitial());

  bool isPasswordObscured = true;

  void togglePasswordVisibility() {
    isPasswordObscured = !isPasswordObscured;
    emit(ObscurePasswordChanged(isPasswordObscured));
  }

  void login(String email, String password) async {
    emit(AuthLoading());
    try {
      // محاكاة الاتصال بالسيرفر
      await Future.delayed(const Duration(seconds: 2));

      if (email.isNotEmpty && password.isNotEmpty) {
        emit(
          AuthSuccess(),
        ); // هنا بيتم إرسال حالة النجاح عشان ينقل للشاشة اللي بعدها
      } else {
        emit(AuthError('الرجاء إدخال البريد الإلكتروني وكلمة المرور'));
      }
    } catch (e) {
      emit(AuthError('حدث خطأ ما، حاول مرة أخرى'));
    }
  }
}
