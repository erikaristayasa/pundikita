part of 'setting_bloc.dart';

abstract class SettingState extends Equatable {
  const SettingState();

  @override
  List<Object> get props => [];
}

class SettingInitial extends SettingState {}

class SettingLoaded extends SettingState {
  final Setting data;

  const SettingLoaded({required this.data});

  @override
  List<Object> get props => [data];
}

class SettingFailure extends SettingState {
  final Failure failure;

  const SettingFailure({required this.failure});

  @override
  List<Object> get props => [failure];
}
