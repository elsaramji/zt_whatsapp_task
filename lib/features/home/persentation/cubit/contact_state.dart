import 'package:equatable/equatable.dart';
import 'package:zt_whatsapp_task/features/auth/domain/entities/user.dart';

abstract class ContactsState extends Equatable {
  const ContactsState();

  @override
  List<Object> get props => [];
}

class ContactsInitial extends ContactsState {}

class ContactsLoading extends ContactsState {}

class ContactsLoaded extends ContactsState {
  final List<User> users;
  const ContactsLoaded(this.users);

  @override
  List<Object> get props => [users];
}

class ContactsError extends ContactsState {
  final String message;
  const ContactsError(this.message);

  @override
  List<Object> get props => [message];
}
