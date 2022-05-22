part of 'zakat_calculate_bloc.dart';

abstract class ZakatCalculateState extends Equatable {
  const ZakatCalculateState();

  @override
  List<Object> get props => [];
}

class ZakatCalculateInitial extends ZakatCalculateState {}

class ZakatCalculateLoading extends ZakatCalculateState {}

class ZakatCalculateSuccess extends ZakatCalculateState {
  final num data;

  const ZakatCalculateSuccess({required this.data});
  @override
  List<Object> get props => [data];
}

class ZakatCalculateFailure extends ZakatCalculateState {
  final Failure failure;

  const ZakatCalculateFailure({required this.failure});
  @override
  List<Object> get props => [failure];
}
