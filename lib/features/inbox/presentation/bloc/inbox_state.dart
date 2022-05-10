part of 'inbox_bloc.dart';

abstract class InboxState extends Equatable {
  const InboxState();

  @override
  List<Object> get props => [];
}

class InboxInitial extends InboxState {}

class InboxLoading extends InboxState {}

class InboxLoaded extends InboxState {
  final List<Inbox> data;

  const InboxLoaded({required this.data});

  @override
  List<Object> get props => [data];
}

class InboxFailure extends InboxState {
  final Failure failure;

  const InboxFailure({required this.failure});

  @override
  List<Object> get props => [failure];
}
