part of 'faq_bloc.dart';

abstract class FaqEvent extends Equatable {
  const FaqEvent();

  @override
  List<Object> get props => [];
}

class FetchFaq extends FaqEvent {}
