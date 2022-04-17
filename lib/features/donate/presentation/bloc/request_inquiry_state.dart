part of 'request_inquiry_bloc.dart';

abstract class RequestInquiryState extends Equatable {
  const RequestInquiryState();

  @override
  List<Object> get props => [];
}

class RequestInquiryInitial extends RequestInquiryState {}

class RequestInquiryLoading extends RequestInquiryState {}

class RequestInquirySuccess extends RequestInquiryState {
  final Donation data;

  const RequestInquirySuccess({required this.data});
  @override
  List<Object> get props => [data];
}

class RequestInquiryFailure extends RequestInquiryState {
  final Failure failure;

  const RequestInquiryFailure({required this.failure});
  @override
  List<Object> get props => [failure];
}
