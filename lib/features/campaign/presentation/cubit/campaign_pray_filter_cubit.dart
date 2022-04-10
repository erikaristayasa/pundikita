import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/static/enums.dart';

class CampaignPrayFilterCubit extends Cubit<PrayFilter> {
  CampaignPrayFilterCubit() : super(PrayFilter.terbaru);

  set setFiler(PrayFilter filter) => emit(filter);
}
