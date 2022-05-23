import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../domain/entities/banner_entity.dart';
import '../../../domain/usecases/get_random_banner.dart';
import '../../../errors/failure.dart';

part 'random_banner_event.dart';
part 'random_banner_state.dart';

class RandomBannerBloc extends Bloc<RandomBannerEvent, RandomBannerState> {
  final GetRandomBanner getRandomBanner;
  RandomBannerBloc({required this.getRandomBanner}) : super(RandomBannerInitial()) {
    on<FetchData>((event, emit) async {
      emit(RandomBannerLoading());

      final result = await getRandomBanner();
      result.fold(
        (failure) => emit(RandomBannerFailure(failure: failure)),
        (data) => emit(RandomBannerLoaded(data: data)),
      );
    });
  }
}
