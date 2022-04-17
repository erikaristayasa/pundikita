import 'package:dartz/dartz.dart';

import '../../../../core/domain/entities/donation_entity.dart';
import '../../../../core/domain/repositories/donate_repository.dart';
import '../../../../core/errors/failure.dart';
import '../../../../core/static/enums.dart';

abstract class RequestInquiryUseCase<Type> {
  Future<Either<Failure, Donation>> call(Map<String, dynamic> request, {CampaignService? service});
}

class RequestInquiry implements RequestInquiryUseCase<bool> {
  final DonateRepository repository;

  RequestInquiry(this.repository);

  @override
  Future<Either<Failure, Donation>> call(Map<String, dynamic> request, {CampaignService? service}) async {
    return await repository.requestInquiry(request, service: service);
  }
}
