import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/errors/failure.dart';
import '../../domain/entities/inbox.dart';
import '../../domain/usecases/get_inbox_list.dart';

part 'inbox_event.dart';
part 'inbox_state.dart';

class InboxBloc extends Bloc<InboxEvent, InboxState> {
  final GetInboxList getInboxList;
  InboxBloc({required this.getInboxList}) : super(InboxInitial()) {
    on<GetData>((event, emit) async {
      emit(InboxLoading());

      await Future.delayed(const Duration(milliseconds: 500));
      final result = await getInboxList();
      result.fold(
        (failure) => emit(InboxFailure(failure: failure)),
        (data) => emit(InboxLoaded(data: data)),
      );
    });
  }
}
