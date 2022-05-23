import 'package:dartz/dartz.dart';

import '../../domain/entities/donation_entity.dart';
import '../../domain/repositories/donate_repository.dart';
import '../../errors/failure.dart';
import '../../network/network_info.dart';
import '../../static/enums.dart';
import '../datasources/donate_data_source.dart';

class DonateRepositoryImplementaion implements DonateRepository {
  final DonateDataSource dataSource;
  final NetworkInfo networkInfo;

  DonateRepositoryImplementaion({required this.dataSource, required this.networkInfo});

  @override
  Future<Either<Failure, Donation>> requestInquiry(Map<String, dynamic> request, {CampaignService? service}) async {
    if (await networkInfo.isConnected) {
      try {
        final result = await dataSource.requestInquiry(request, service: service);
        return Right(result);
      } catch (e) {
        return Left(ServerFailure());
      }
    }
    return Left(ConnectionFailure());
  }

  @override
  Future<Either<Failure, List<Donation>>> getDonationList({required CampaignService service}) async {
    if (await networkInfo.isConnected) {
      try {
        final result = await dataSource.getDonationList(service: service);
        return Right(result);
      } catch (e) {
        return Left(ServerFailure());
      }
    }
    return Left(ConnectionFailure());
  }

  @override
  Future<bool> like({required int donationId}) async {
    return await dataSource.like(donationId: donationId);
  }

  @override
  Future<bool> unlike({required int donationId}) async {
    return await dataSource.unlike(donationId: donationId);
  }

  @override
  Future<Either<Failure, List<Donation>>> getDonationAllList() async {
    if (await networkInfo.isConnected) {
      try {
        final result = await dataSource.getDonationAllList();
        return Right(result);
      } catch (e) {
        return Left(ServerFailure());
      }
    }
    return Left(ConnectionFailure());
  }
}
