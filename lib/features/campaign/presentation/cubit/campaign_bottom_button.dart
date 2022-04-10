import 'package:flutter_bloc/flutter_bloc.dart';

class CampaignBottomButtonCubit extends Cubit<bool> {
  CampaignBottomButtonCubit(bool initialState) : super(initialState);

  void hide() => emit(false);
  void show() => emit(true);
}
