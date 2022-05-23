import 'package:dartz/dartz.dart';
import 'package:pundi_kita/core/domain/entities/donation_entity.dart';
import 'package:pundi_kita/core/domain/repositories/donate_repository.dart';
import 'package:pundi_kita/core/errors/failure.dart';

abstract class AllDonationUseCase<Type> {
  Future<Either<Failure, List<Donation>>> call();
}

class GetAllDonation implements AllDonationUseCase<List<Donation>> {
  final DonateRepository repository;

  GetAllDonation(this.repository);

  @override
  Future<Either<Failure, List<Donation>>> call() async {
    return await repository.getDonationAllList();
  }
}
