part of 'profile_bloc.dart';

abstract class ProfileEvent extends Equatable {
  const ProfileEvent();

  @override
  List<Object> get props => [];
}

class FetchProfile extends ProfileEvent {}

class SubmitUpdate extends ProfileEvent {
  final FormData data;

  const SubmitUpdate({required this.data});

  @override
  List<Object> get props => [data];
}

class SubmitVerificationData extends ProfileEvent {
  final Map<String, dynamic> map;

  const SubmitVerificationData({
    required this.map,
  });

  @override
  List<Object> get props => [map];
}
