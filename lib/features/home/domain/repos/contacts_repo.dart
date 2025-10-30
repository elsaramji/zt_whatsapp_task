import 'package:dartz/dartz.dart';
import 'package:zt_whatsapp_task/features/auth/domain/entities/user.dart';

abstract class ContactsRepo {
  Future<Either<Exception, List<User>>> getContact();
}
