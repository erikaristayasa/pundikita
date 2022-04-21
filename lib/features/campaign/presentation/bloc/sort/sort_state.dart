part of 'sort_bloc.dart';

abstract class SortState extends Equatable {
  const SortState();

  @override
  List<Object> get props => [];
}

class SortInitial extends SortState {
  final bool value;

  const SortInitial({required this.value});

  @override
  List<Object> get props => [value];
}
