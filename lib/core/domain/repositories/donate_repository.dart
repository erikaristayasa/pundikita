import 'package:dartz/dartz.dart';

import '../../errors/failure.dart';
import '../../static/enums.dart';
import '../entities/donation_entity.dart';

abstract class DonateRepository {
  Future<Either<Failure, Donation>> requestInquiry(Map<String, dynamic> request, {CampaignService? service});
  Future<Either<Failure, List<Donation>>> getDonationList({required CampaignService service});
  Future<Either<Failure, List<Donation>>> getDonationAllList();
  Future<bool> like({required int donationId});
  Future<bool> unlike({required int donationId});
}
