import 'package:bloc/bloc.dart';

class NominalCubit extends Cubit<int?> {
  NominalCubit() : super(null);

  void onSelect(int nominal) => emit(nominal);
  bool isSelected(int nominal) => nominal == state;
  void onInput(String? nominal) {
    try {
      final parsedValue = int.parse((nominal ?? '0').replaceAll('.', ''));
      if (parsedValue >= 10000) {
        emit(parsedValue);
      } else {
        emit(null);
      }
    } catch (e) {
      emit(null);
    }
  }
}
