part of 'all_donation_bloc.dart';

abstract class AllDonationState extends Equatable {
  const AllDonationState();

  @override
  List<Object> get props => [];
}

class AllDonationInitial extends AllDonationState {}

class AllDonationLoading extends AllDonationState {}

class AllDonationLoaded extends AllDonationState {
  final List<Donation> data;

  const AllDonationLoaded({required this.data});

  @override
  List<Object> get props => [data];
}

class AllDonationFailure extends AllDonationState {
  final Failure failure;

  const AllDonationFailure({required this.failure});

  @override
  List<Object> get props => [failure];
}
