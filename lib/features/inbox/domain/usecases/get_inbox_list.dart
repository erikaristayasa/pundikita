import 'package:dartz/dartz.dart';

import '../../../../core/errors/failure.dart';
import '../entities/inbox.dart';
import '../repositories/inbox_repository.dart';

abstract class InboxListUseCase<Type> {
  Future<Either<Failure, List<Inbox>>> call();
}

class GetInboxList implements InboxListUseCase<List<Inbox>> {
  final InboxRepository repository;

  GetInboxList(this.repository);

  @override
  Future<Either<Failure, List<Inbox>>> call() async {
    return await repository.getInboxList();
  }
}
