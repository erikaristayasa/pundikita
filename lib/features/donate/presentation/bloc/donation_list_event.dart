part of 'donation_list_bloc.dart';

abstract class DonationListEvent extends Equatable {
  const DonationListEvent();

  @override
  List<Object> get props => [];
}

class GetData extends DonationListEvent {
  final CampaignService service;

  const GetData({required this.service});

  @override
  List<Object> get props => [service];
}
