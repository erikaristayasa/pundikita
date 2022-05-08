part of 'campaign_create_bloc.dart';

abstract class CampaignCreateEvent extends Equatable {
  const CampaignCreateEvent();

  @override
  List<Object> get props => [];
}

class UpdateBody extends CampaignCreateEvent {
  final Map<String, dynamic> body;

  const UpdateBody({required this.body});
  @override
  List<Object> get props => [body];
}

class Submit extends CampaignCreateEvent {}
