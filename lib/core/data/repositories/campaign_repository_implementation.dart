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
  Future<Either<Failure, List<Campaign>>> getAllCampaignList(CampaignService service, {bool auth = false, CampaignCategory? category, bool? sort}) async {
    try {
      final result = await dataSource.getCampaignList(service, auth: auth, category: category, sort: sort);
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
  Future<Either<Failure, List<CampaignCategory>>> getCampaignCategories() async {
    try {
      final result = await dataSource.getCategories();
      return Right(result);
    } catch (e) {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, List<CampaignSubCategory>>> getCampaignSubCategories() {
    // TODO: implement getCampaignSubCategories
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, List<CampaignType>>> getCampaignTypes() {
    // TODO: implement getCampaignTypes
    throw UnimplementedError();
  }
}
