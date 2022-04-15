import 'package:dartz/dartz.dart';

import '../../../../core/errors/failure.dart';
import '../../../../core/network/network_info.dart';
import '../../../../core/static/enums.dart';
import '../../domain/repositories/donate_repository.dart';
import '../datasources/donate_data_source.dart';

class DonateRepositoryImplementaion implements DonateRepository {
  final DonateDataSource dataSource;
  final NetworkInfo networkInfo;

  DonateRepositoryImplementaion({required this.dataSource, required this.networkInfo});

  @override
  Future<Either<Failure, bool>> requestInquiry(Map<String, dynamic> request, {CampaignService? service}) async {
    if (await networkInfo.isConnected) {
      final result = await dataSource.requestInquiry(request, service: service);
      return Right(result);
    }
    return Left(ConnectionFailure());
  }
}
