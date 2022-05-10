import 'package:dartz/dartz.dart';
import 'package:pundi_kita/core/errors/failure.dart';
import 'package:pundi_kita/features/inbox/domain/entities/inbox.dart';

abstract class InboxRepository {
  Future<Either<Failure, List<Inbox>>> getInboxList();
}
