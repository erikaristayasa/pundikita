part of 'profile_bloc.dart';

abstract class ProfileState extends Equatable {
  const ProfileState();

  @override
  List<Object> get props => [];
}

class ProfileInitial extends ProfileState {}

class ProfileLoading extends ProfileState {}

class ProfileLoaded extends ProfileState {
  final User data;

  const ProfileLoaded({required this.data});

  @override
  List<Object> get props => [data];
}

class ProfileFailure extends ProfileState {
  final Failure failure;

  const ProfileFailure({required this.failure});

  @override
  List<Object> get props => [failure];
}

class ProfileUpdating extends ProfileState {}

class ProfileUpdated extends ProfileState {}
