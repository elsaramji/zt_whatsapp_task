import 'package:equatable/equatable.dart';
import 'package:zt_whatsapp_task/features/auth/domain/entities/user.dart';

// الفئة الأساسية (Abstract) للحالات
abstract class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object> get props => [];
}

// الحالة الأولية (عند بدء التشغيل)
class AuthInitial extends AuthState {}

// حالة التحميل (عند الضغط على "Next")
class AuthLoading extends AuthState {}

// حالة النجاح (عند تسجيل الدخول بنجاح)
class AuthSuccess extends AuthState {
  final User user;
  const AuthSuccess(this.user);

  @override
  List<Object> get props => [user];
}

// حالة الفشل (عند حدوث خطأ)
class AuthFailure extends AuthState {
  final String errorMessage;
  const AuthFailure(this.errorMessage);

  @override
  List<Object> get props => [errorMessage];
}
