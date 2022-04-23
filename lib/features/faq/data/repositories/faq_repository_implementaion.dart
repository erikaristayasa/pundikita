import 'package:dartz/dartz.dart';

import '../../domain/entities/faq_entity.dart';
import '../../domain/repositories/faq_repository.dart';
import '../../../../core/errors/failure.dart';
import '../../../../core/network/network_info.dart';
import '../datasources/faq_data_source.dart';

class FaqRepositoryImplementation implements FaqRepository {
  final FaqDataSource dataSource;
  final NetworkInfo networkInfo;

  FaqRepositoryImplementation({
    required this.dataSource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, List<Faq>>> getFaqList() async {
    if (await networkInfo.isConnected) {
      try {
        final result = await dataSource.getFaqList();
        return Right(result);
      } catch (e) {
        return Left(ServerFailure());
      }
    }
    return Left(ConnectionFailure());
  }
}
