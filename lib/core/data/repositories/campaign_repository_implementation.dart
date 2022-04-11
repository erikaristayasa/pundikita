import 'package:dartz/dartz.dart';

import '../../domain/entities/campaign_entity.dart';
import '../../domain/repositories/campaign_repository.dart';
import '../../errors/failure.dart';
import '../../static/enums.dart';
import '../datasources/campaign_data_source.dart';

class CampaignRepositoryImplementation implements CampaignRepository {
  final CampaignDataSource dataSource;

  CampaignRepositoryImplementation({required this.dataSource});

  @override
  Future<Either<Failure, List<Campaign>>> getAllCampaignList(CampaignService service) async {
    try {
      final result = await dataSource.getCampaignList(service);
      return Right(result);
    } catch (e) {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, Campaign>> getCampaignDetail(int id, {required CampaignService service}) async {
    try {
      final result = await dataSource.getCampaignDetail(id, service: service);
      return Right(result);
    } catch (e) {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, List<Campaign>>> getUserCampaignList(CampaignService service) async {
    try {
      final result = await dataSource.getCampaignList(service, auth: true);
      return Right(result);
    } catch (e) {
      return Left(ServerFailure());
    }
  }
}
