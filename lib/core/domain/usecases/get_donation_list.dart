import 'package:dartz/dartz.dart';

import '../../errors/failure.dart';
import '../../static/enums.dart';
import '../entities/donation_entity.dart';
import '../repositories/donate_repository.dart';

abstract class DonationListUseCase<Type> {
  Future<Either<Failure, List<Donation>>> call({required CampaignService service});
}

class GetDonationList implements DonationListUseCase<List<Donation>> {
  final DonateRepository repository;

  GetDonationList(this.repository);

  @override
  Future<Either<Failure, List<Donation>>> call({required CampaignService service}) async {
    return await repository.getDonationList(service: service);
  }
}
