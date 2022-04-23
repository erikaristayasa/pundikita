part of 'faq_bloc.dart';

abstract class FaqState extends Equatable {
  const FaqState();

  @override
  List<Object> get props => [];
}

class FaqInitial extends FaqState {}

class FaqLoaded extends FaqState {
  final List<Faq> data;

  const FaqLoaded({required this.data});

  @override
  List<Object> get props => [data];
}

class FaqFailure extends FaqState {
  final Failure failure;

  const FaqFailure({required this.failure});

  @override
  List<Object> get props => [failure];
}
