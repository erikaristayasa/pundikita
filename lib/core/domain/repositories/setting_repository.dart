import 'package:dartz/dartz.dart';

import '../../errors/failure.dart';
import '../entities/setting_entity.dart';

abstract class SettingRepository {
  Future<Either<Failure, Setting>> getSetting();
}
