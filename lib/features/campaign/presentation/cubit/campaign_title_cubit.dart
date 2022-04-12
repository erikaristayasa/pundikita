import 'package:bloc/bloc.dart';

class CampaignTitleCubit extends Cubit<String> {
  String _title = '';

  // CampaignTitleCubit({required this.title}) : super('');
  CampaignTitleCubit(String initialState) : super(initialState);

  void setTitle({required String title}) {
    _title = title;
    emit(_title);
  }

  void change({String? title}) => emit(title ?? _title);
}
