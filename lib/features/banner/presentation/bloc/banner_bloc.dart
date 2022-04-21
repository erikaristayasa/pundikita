import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:pundi_kita/core/errors/failure.dart';
import 'package:pundi_kita/features/banner/domain/entities/banner_entity.dart';

import '../../domain/usecases/get_banners.dart';

part 'banner_event.dart';
part 'banner_state.dart';

class BannerBloc extends Bloc<BannerEvent, BannerState> {
  final GetBanners getBanners;
  BannerBloc({required this.getBanners}) : super(BannerInitial()) {
    on<BannerEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
