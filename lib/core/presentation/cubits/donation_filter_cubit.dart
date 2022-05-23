import 'package:flutter_bloc/flutter_bloc.dart';

import '../../static/enums.dart';

class DonationFilterCubit extends Cubit<DonationFilter> {
  DonationFilterCubit() : super(DonationFilter.terbaru);

  set setFiler(DonationFilter filter) => emit(filter);
}
