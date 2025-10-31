import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zt_whatsapp_task/features/home/data/repos/contacts_repo_impl.dart';
import 'package:zt_whatsapp_task/features/home/data/source/get_contact_source.dart';
import 'package:zt_whatsapp_task/features/home/domain/usecase/get_contents_usecase.dart';

import 'contact_state.dart';

class ContactsCubit extends Cubit<ContactsState> {
  GetContactsUseCase getContactsUseCase = GetContactsUseCase(
    ContactsRepoImpl(GetContactSourceImpl()),
  );

  ContactsCubit() : super(ContactsInitial());

  Future<void> getContacts() async {
    emit(ContactsLoading());

    final result = await getContactsUseCase.call();
    result.fold(
      (failure) => emit(ContactsError(failure.toString())),
      (users) => emit(ContactsLoaded(users)),
    );
  }
}
