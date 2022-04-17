part of 'request_inquiry_bloc.dart';

abstract class RequestInquiryEvent extends Equatable {
  const RequestInquiryEvent();

  @override
  List<Object> get props => [];
}

class OnSubmit extends RequestInquiryEvent {
  final Campaign campaign;
  final PaymentMethod method;
  final PaymentChannel channel;
  final String pray;
  final int nominal;

  const OnSubmit({
    required this.campaign,
    required this.method,
    required this.channel,
    required this.pray,
    required this.nominal,
  });

  @override
  List<Object> get props => [
        campaign,
        method,
        channel,
        pray,
        nominal,
      ];
}
