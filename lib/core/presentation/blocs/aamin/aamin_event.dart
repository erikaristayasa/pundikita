part of 'aamin_bloc.dart';

abstract class AaminEvent extends Equatable {
  const AaminEvent();

  @override
  List<Object> get props => [];
}

class LikeUnlike extends AaminEvent {
  final int donationId;

  const LikeUnlike({required this.donationId});

  @override
  List<Object> get props => [donationId];
}

class Initial extends AaminEvent {
  final bool likeStatus;

  const Initial({required this.likeStatus});
  @override
  List<Object> get props => [likeStatus];
}
