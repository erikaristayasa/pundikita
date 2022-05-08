part of 'aamin_bloc.dart';

abstract class AaminState extends Equatable {
  final bool status;
  const AaminState(this.status);

  @override
  List<Object> get props => [status];
}

class AaminInitial extends AaminState {
  const AaminInitial(bool status) : super(status);
}

class AaminLoading extends AaminState {
  const AaminLoading(bool status) : super(status);
}

class AaminLiked extends AaminState {
  const AaminLiked(bool status) : super(status);
}

class AaminUnliked extends AaminState {
  const AaminUnliked(bool status) : super(status);
}
