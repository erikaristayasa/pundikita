part of 'all_donation_bloc.dart';

abstract class AllDonationEvent extends Equatable {
  const AllDonationEvent();

  @override
  List<Object> get props => [];
}

class FetchData extends AllDonationEvent {}
