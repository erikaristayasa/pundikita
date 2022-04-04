import 'package:bloc/bloc.dart';

class CampaignTitleCubit extends Cubit<String> {
  CampaignTitleCubit(String initialState) : super(initialState);

  void change(String newTitle) => emit(newTitle);
}
