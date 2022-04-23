import 'package:dartz/dartz.dart';

import '../../errors/failure.dart';
import '../entities/setting_entity.dart';
import '../repositories/setting_repository.dart';

abstract class SettingUseCase<Type> {
  Future<Either<Failure, Setting>> call();
}

class GetSetting implements SettingUseCase<List<Setting>> {
  final SettingRepository repository;

  GetSetting(this.repository);

  @override
  Future<Either<Failure, Setting>> call() async {
    return await repository.getSetting();
  }
}
