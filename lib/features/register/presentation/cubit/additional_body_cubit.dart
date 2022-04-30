import 'package:flutter_bloc/flutter_bloc.dart';

class AdditionalBodyCubit extends Cubit<Map<String, dynamic>> {
  AdditionalBodyCubit() : super({});

  setValue(Map<String, dynamic> value) => emit(value);
}
