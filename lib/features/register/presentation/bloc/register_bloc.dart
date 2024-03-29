import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pundi_kita/core/utility/helper.dart';

import '../../domain/entities/register_request_body.dart';
import '../../domain/usecases/do_register.dart';

part 'register_event.dart';
part 'register_state.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  final Register register;
  RegisterBloc({required this.register}) : super(RegisterInitial()) {
    on<RegisterSubmit>((event, emit) async {
      emit(RegisterLoading());

      final result = await register(
        getBody(event),
        additionalBody: convertFileToMultipartFile(event.additonalBody),
      );
      result.fold(
        (message) => emit(RegisterError(message: message)),
        (_) => emit(RegisterSuccess()),
      );
    });
  }

  RegisterRequestBody getBody(RegisterSubmit event) {
    final RegisterRequestBody body = RegisterRequestBody(
      photo: event.photo,
      name: event.name,
      email: event.email,
      password: event.password,
      passwordConfirmation: event.passwordConfirmation,
      phone: event.phone,
      donatureType: event.donatureType,
    );
    return body;
  }
}
