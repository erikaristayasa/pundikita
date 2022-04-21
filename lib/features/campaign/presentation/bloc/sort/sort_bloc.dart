import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'sort_event.dart';
part 'sort_state.dart';

class SortBloc extends Bloc<SortEvent, SortState> {
  SortBloc() : super(const SortInitial(value: false)) {
    on<OnChanged>((event, emit) {
      emit(SortInitial(value: event.value));
    });
  }
}
