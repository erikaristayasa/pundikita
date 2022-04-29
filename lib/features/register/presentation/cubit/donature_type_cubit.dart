import 'package:bloc/bloc.dart';
import 'package:pundi_kita/core/static/enums.dart';

class DonatureTypeCubit extends Cubit<DonatureType> {
  DonatureTypeCubit() : super(DonatureType.personal);

  change(DonatureType type) => emit(type);
}
