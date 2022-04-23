import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/domain/entities/setting_entity.dart';
import '../../../../core/domain/usecases/get_setting.dart';
import '../../../../core/errors/failure.dart';

part 'setting_event.dart';
part 'setting_state.dart';

class SettingBloc extends Bloc<SettingEvent, SettingState> {
  final GetSetting getSetting;
  SettingBloc({required this.getSetting}) : super(SettingInitial()) {
    on<FetchSetting>((event, emit) async {
      final result = await getSetting();
      result.fold(
        (failure) => SettingFailure(failure: failure),
        (data) => SettingLoaded(data: data),
      );
    });
  }
}
