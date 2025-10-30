import 'package:dartz/dartz.dart';
import 'package:zt_whatsapp_task/features/home/domain/repos/contacts_repo.dart';
import '../../../auth/domain/entities/user.dart';

class GetContactsUseCase {

  ContactsRepo contactsRepo;
  GetContactsUseCase(this.contactsRepo);

  Future<Either<Exception, List<User>>> call() async {
    return await contactsRepo.getContact();
  }
}
