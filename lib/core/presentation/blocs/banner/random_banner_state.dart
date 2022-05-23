part of 'random_banner_bloc.dart';

abstract class RandomBannerState extends Equatable {
  const RandomBannerState();

  @override
  List<Object> get props => [];
}

class RandomBannerInitial extends RandomBannerState {}

class RandomBannerLoading extends RandomBannerState {}

class RandomBannerFailure extends RandomBannerState {
  final Failure failure;

  const RandomBannerFailure({required this.failure});
  @override
  List<Object> get props => [failure];
}

class RandomBannerLoaded extends RandomBannerState {
  final Banner data;

  const RandomBannerLoaded({required this.data});

  @override
  List<Object> get props => [data];
}
