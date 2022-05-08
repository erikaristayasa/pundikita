import 'package:pundi_kita/core/domain/repositories/donate_repository.dart';

abstract class LikeUnlikeUseCase<Type> {
  Future<bool> call({required int donationId});
}

class DoLike implements LikeUnlikeUseCase<bool> {
  final DonateRepository repository;

  DoLike(this.repository);

  @override
  Future<bool> call({required int donationId}) async {
    return await repository.like(donationId: donationId);
  }
}

class DoUnLike implements LikeUnlikeUseCase<bool> {
  final DonateRepository repository;

  DoUnLike(this.repository);

  @override
  Future<bool> call({required int donationId}) async {
    return await repository.unlike(donationId: donationId);
  }
}
