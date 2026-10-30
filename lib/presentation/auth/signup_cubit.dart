import 'package:flutter_bloc/flutter_bloc.dart';
part 'signup_state.dart';

class SignupCubit extends Cubit<SignupState> {
  SignupCubit() : super(SignupInitial());

  bool isPasswordObscured = true;
  bool isAgreedToTerms = false;

  void togglePasswordVisibility() {
    isPasswordObscured = !isPasswordObscured;
    emit(SignupPasswordVisibilityChanged(isPasswordObscured));
  }

  void toggleTermsAgreement(bool value) {
    isAgreedToTerms = value;
    emit(SignupTermsChanged(isAgreedToTerms));
  }

  void signUp({
    required String name,
    required String email,
    required String password,
    required String confirmPassword,
  }) async {
    if (name.isEmpty || email.isEmpty || password.isEmpty || confirmPassword.isEmpty) {
      emit(SignupError('الرجاء ملء جميع الحقول المطلوبة'));
      return;
    }

    if (password != confirmPassword) {
      emit(SignupError('كلمة المرور غير متطابقة'));
      return;
    }

    if (!isAgreedToTerms) {
      emit(SignupError('يجب الموافقة على الشروط والأحكام أولاً'));
      return;
    }

    emit(SignupLoading());
    try {
      // محاكاة إرسال البيانات للخادم (API Request)
      await Future.delayed(const Duration(seconds: 2));
      emit(SignupSuccess());
    } catch (e) {
      emit(SignupError('حدث خطأ أثناء إنشاء الحساب، حاول مرة أخرى'));
    }
  }
}