import 'package:dartz/dartz.dart';

import '../../../auth/domain/entities/user.dart';
import '../../domain/repos/contacts_repo.dart';

class ContactsRepoImpl implements ContactsRepo {
  final ContactsRepo contactsRepo;
  ContactsRepoImpl(this.contactsRepo);
  @override
  Future<Either<Exception, List<User>>> getContact() async {
    return contactsRepo.getContact();
  }
}
