import 'package:flutter_bloc/flutter_bloc.dart';

class DonatePrayCubit extends Cubit<String> {
  DonatePrayCubit() : super("");

  void onChanged(String value) => emit(value);
}
