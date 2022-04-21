part of 'sort_bloc.dart';

abstract class SortEvent extends Equatable {
  const SortEvent();

  @override
  List<Object> get props => [];
}

class OnChanged extends SortEvent {
  final bool value;

  const OnChanged({required this.value});

  @override
  List<Object> get props => [value];
}
