import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/utility/locator.dart';
import '../../../../core/utility/shared_preferences_helper.dart';
import '../../domain/usecases/do_login.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final DoLogin doLogin;

  LoginBloc({required this.doLogin}) : super(LoginInitial()) {
    on<LoginSubmitted>((event, emit) async {
      emit(LoginLoading());

      final result = await doLogin(email: event.email, password: event.password);
      result.fold((error) => emit(LoginError(message: error)), (token) {
        _saveToken(token);
        emit(LoginSuccess());
      });
    });
  }

  _saveToken(String token) async {
    final session = locator<SharedPreferencesHelper>();
    await session.saveToken(token);
    await session.logIn();
  }
}
