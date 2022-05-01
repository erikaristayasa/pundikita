part of 'donation_list_bloc.dart';

abstract class DonationListState extends Equatable {
  const DonationListState();

  @override
  List<Object> get props => [];
}

class DonationListInitial extends DonationListState {}

class DonationListLoading extends DonationListState {}

class DonationListLoaded extends DonationListState {
  final List<Donation> data;

  const DonationListLoaded({required this.data});

  @override
  List<Object> get props => [data];
}

class DonationListFailure extends DonationListState {
  final Failure failure;

  const DonationListFailure({required this.failure});

  @override
  List<Object> get props => [failure];
}
