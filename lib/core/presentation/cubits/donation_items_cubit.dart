import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/entities/donation_entity.dart';
import '../../static/enums.dart';

class DonationItemsCubit extends Cubit<List<Donation>> {
  final List<Donation> donation;

  DonationItemsCubit({required this.donation}) : super(donation);

  void filter(DonationFilter filter) {
    switch (filter) {
      case DonationFilter.terbaru:
        emit([]);
        donation.sort((a, b) => b.id.compareTo(a.id));
        emit(donation);
        break;
      case DonationFilter.terpopuler:
        emit([]);
        donation.sort((a, b) => b.likeStatus ? 1 : -1);
        emit(donation);
        break;
    }
  }
}
