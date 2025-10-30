import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zt_whatsapp_task/features/auth/data/repos/auth_repo_impl.dart';
import 'package:zt_whatsapp_task/features/auth/data/source/firebase_data_source.dart';
import 'package:zt_whatsapp_task/features/auth/domain/usecase/sign_in_usecase.dart';

import 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final SignInUseCase _signInUseCase = SignInUseCase(
    AuthRepoImpl(FirebaseDataSourceImpl()),
  );

  AuthCubit() : super(AuthInitial());

  // هذه هي الدالة التي ستستدعيها الواجهة
  Future<void> loginUser(String phoneNumber) async {
    // 1. إصدار حالة التحميل لإظهار Spinner
    emit(AuthLoading());

    // 2. تنفيذ الـ UseCase
    // سيقوم الـ UseCase باستدعاء الـ Repo -> DataSource -> Firebase
    final result = await _signInUseCase.call(phoneNumber);

    // 3. معالجة النتيجة (Either)
    result.fold(
      // 3a. في حالة الفشل (Left)
      (exception) {
        // إصدار حالة الفشل مع رسالة الخطأ
        emit(AuthFailure(exception.toString()));
      },
      // 3b. في حالة النجاح (Right)
      (user) {
        // إصدار حالة النجاح مع بيانات المستخدم
        emit(AuthSuccess(user));
      },
    );
  }
}
