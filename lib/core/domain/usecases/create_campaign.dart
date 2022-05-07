import 'package:dartz/dartz.dart';

import '../../errors/failure.dart';
import '../repositories/campaign_repository.dart';

abstract class CreateCampaignUseCase<Type> {
  Future<Either<Failure, bool>> call(Map<String, dynamic> body);
}

class CreateCampaign implements CreateCampaignUseCase<bool> {
  final CampaignRepository repository;

  CreateCampaign(this.repository);

  @override
  Future<Either<Failure, bool>> call(Map<String, dynamic> body) async {
    return await repository.createCampaign(body);
  }
}
