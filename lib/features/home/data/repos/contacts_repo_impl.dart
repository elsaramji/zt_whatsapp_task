import 'package:dartz/dartz.dart';
import 'package:zt_whatsapp_task/features/home/data/source/get_contact_source.dart';

import '../../../auth/domain/entities/user.dart';
import '../../domain/repos/contacts_repo.dart';

class ContactsRepoImpl implements ContactsRepo {
  final  GetContactSource contactsSource;
  ContactsRepoImpl(this.contactsSource);
  @override
  Future<Either<Exception, List<User>>> getContact() async {
    return contactsSource.getContact();
  }
}
