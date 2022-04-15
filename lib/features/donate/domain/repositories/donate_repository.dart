import 'package:dartz/dartz.dart';
import 'package:pundi_kita/core/errors/failure.dart';
import 'package:pundi_kita/core/static/enums.dart';

abstract class DonateRepository {
  Future<Either<Failure, bool>> requestInquiry(Map<String, dynamic> request, {CampaignService? service});
}
