import 'package:dartz/dartz.dart';

import '../../../../core/errors/failure.dart';
import '../entities/faq_entity.dart';
import '../repositories/faq_repository.dart';

abstract class FaqUseCase<Type> {
  Future<Either<Failure, List<Faq>>> call();
}

class GetFaqList implements FaqUseCase<List<Faq>> {
  final FaqRepository repository;

  GetFaqList(this.repository);

  @override
  Future<Either<Failure, List<Faq>>> call() async {
    return await repository.getFaqList();
  }
}
