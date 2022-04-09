import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:pundi_kita/core/utility/helper.dart';

import '../../domain/usecases/forgot_password.dart';

part 'forgot_password_event.dart';
part 'forgot_password_state.dart';

class ForgotPasswordBloc extends Bloc<ForgotPasswordEvent, ForgotPasswordState> {
  final ForgotPassword forgotPassword;

  ForgotPasswordBloc({required this.forgotPassword}) : super(ForgotPasswordInitial()) {
    on<ForgotPasswordSubmitted>((event, emit) async {
      emit(ForgotPasswordLoading());

      final result = await forgotPassword(event.email);
      result.fold(
        (error) => emit(ForgotPasswordError(message: error)),
        (message) {
          logMe(message);
          emit(ForgotPasswordSuccess());
        },
      );
    });
  }
}
