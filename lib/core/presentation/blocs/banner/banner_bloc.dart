import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/errors/failure.dart';
import '../../../../core/domain/entities/banner_entity.dart';
import '../../../../core/domain/usecases/get_banners.dart';
import '../../../domain/entities/banner_entity.dart';

part 'banner_event.dart';
part 'banner_state.dart';

class BannerBloc extends Bloc<BannerEvent, BannerState> {
  final GetBanners getBanners;
  BannerBloc({required this.getBanners}) : super(BannerInitial()) {
    on<FetchData>((event, emit) async {
      emit(BannerLoading());

      await Future.delayed(const Duration(milliseconds: 1000), () async {
        final result = await getBanners();
        result.fold(
          (failure) => emit(BannerFailure(failure: failure)),
          (data) => emit(BannerLoaded(data: data)),
        );
      });
    });
  }
}
