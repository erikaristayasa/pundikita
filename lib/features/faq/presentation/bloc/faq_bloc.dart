import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../domain/entities/faq_entity.dart';
import '../../domain/usecases/get_faq_list.dart';
import '../../../../core/errors/failure.dart';

part 'faq_event.dart';
part 'faq_state.dart';

class FaqBloc extends Bloc<FaqEvent, FaqState> {
  final GetFaqList getFaqList;
  FaqBloc({required this.getFaqList}) : super(FaqInitial()) {
    on<FetchFaq>((event, emit) async {
      await Future.delayed(const Duration(milliseconds: 1300), () async {
        final result = await getFaqList();
        result.fold(
          (failure) => emit(FaqFailure(failure: failure)),
          (data) => emit(FaqLoaded(data: data)),
        );
      });
    });
  }
}
