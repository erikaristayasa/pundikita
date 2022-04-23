import 'package:dartz/dartz.dart';

import '../../../../core/errors/failure.dart';
import '../entities/faq_entity.dart';

abstract class FaqRepository {
  Future<Either<Failure, List<Faq>>> getFaqList();
}
