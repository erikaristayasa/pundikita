import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'verify_account_event.dart';
part 'verify_account_state.dart';

class VerifyAccountBloc extends Bloc<VerifyAccountEvent, VerifyAccountState> {
  VerifyAccountBloc() : super(VerifyAccountInitial()) {
    on<VerifyAccountEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
