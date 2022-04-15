import 'package:dartz/dartz.dart';

import '../../../../core/errors/failure.dart';
import '../../../../core/static/enums.dart';
import '../repositories/donate_repository.dart';

abstract class DonateUseCase<Type> {
  Future<Either<Failure, bool>> call(Map<String, dynamic> request, {CampaignService? service});
}

class RequestInquiry implements DonateUseCase<bool> {
  final DonateRepository repository;

  RequestInquiry(this.repository);

  @override
  Future<Either<Failure, bool>> call(Map<String, dynamic> request, {CampaignService? service}) async {
    return await repository.requestInquiry(request, service: service);
  }
}
