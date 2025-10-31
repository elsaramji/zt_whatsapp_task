import 'package:equatable/equatable.dart';
import 'package:zt_whatsapp_task/features/auth/domain/entities/user.dart';

// The base (Abstract) class for states
abstract class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object> get props => [];
}

// Initial state (at startup)
class AuthInitial extends AuthState {}

// Loading state (when "Next" is pressed)
class AuthLoading extends AuthState {}

// Success state (when login is successful)
class AuthSuccess extends AuthState {
  final User user;
  const AuthSuccess(this.user);

  @override
  List<Object> get props => [user];
}

// Failure state (when an error occurs)
class AuthFailure extends AuthState {
  final String errorMessage;
  const AuthFailure(this.errorMessage);

  @override
  List<Object> get props => [errorMessage];
}
