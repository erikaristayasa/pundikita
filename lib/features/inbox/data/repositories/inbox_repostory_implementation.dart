import 'package:dartz/dartz.dart';

import '../../../../core/errors/failure.dart';
import '../../../../core/network/network_info.dart';
import '../../domain/entities/inbox.dart';
import '../../domain/repositories/inbox_repository.dart';
import '../datasources/inbox_data_source.dart';

class InboxRepositoryImplementation implements InboxRepository {
  final NetworkInfo networkInfo;
  final InboxDataSource dataSource;

  InboxRepositoryImplementation({
    required this.networkInfo,
    required this.dataSource,
  });

  @override
  Future<Either<Failure, List<Inbox>>> getInboxList() async {
    if (await networkInfo.isConnected) {
      try {
        final result = await dataSource.getInboxList();
        return Right(result);
      } catch (e) {
        return Left(ServerFailure());
      }
    }
    return Left(ConnectionFailure());
  }
}
