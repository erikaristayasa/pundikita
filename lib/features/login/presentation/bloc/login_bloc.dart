import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:pundi_kita/core/utility/app_locale.dart';
import 'package:pundi_kita/core/utility/google_signin_helper.dart';
import 'package:pundi_kita/features/login/domain/usecases/do_login_by_google.dart';

import '../../../../core/utility/locator.dart';
import '../../../../core/utility/shared_preferences_helper.dart';
import '../../domain/usecases/do_login.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final DoLogin doLogin;
  final DoLoginByGoogle doLoginByGoogle;

  LoginBloc({required this.doLoginByGoogle, required this.doLogin}) : super(LoginInitial()) {
    on<LoginSubmitted>((event, emit) async {
      emit(LoginLoading());

      final result = await doLogin(email: event.email, password: event.password);
      result.fold(
        (error) => emit(LoginError(message: error + '. Pastikan anda telah melakukan verifikasi akun lewat tautan yang dikirim ke email.')),
        (token) {
          _saveToken(token);
          emit(LoginSuccess());
        },
      );
    });

    on<LoginByGoogle>((event, emit) async {
      emit(LoginLoading());

      final account = await GoogleSignInHelper().signIn();
      if (account != null) {
        final result = await doLoginByGoogle(
          googleUid: account.id,
          name: account.displayName,
          email: account.email,
          phone: null,
        );

        result.fold(
          (error) => emit(LoginError(message: error)),
          (token) {
            _saveToken(token);
            emit(LoginSuccess());
          },
        );
      } else {
        emit(LoginError(message: AppLocale.loc.failure));
      }
    });
  }

  _saveToken(String token) async {
    final session = locator<SharedPreferencesHelper>();
    await session.saveToken(token);
    await session.logIn();
  }
}
