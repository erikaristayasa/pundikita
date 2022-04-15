import 'package:bloc/bloc.dart';

class DonateNominalCubit extends Cubit<int?> {
  DonateNominalCubit() : super(null);

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
