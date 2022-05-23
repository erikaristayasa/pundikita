part of 'random_banner_bloc.dart';

abstract class RandomBannerEvent extends Equatable {
  const RandomBannerEvent();

  @override
  List<Object> get props => [];
}

class FetchData extends RandomBannerEvent {}
