part of 'verify_account_bloc.dart';

abstract class VerifyAccountState extends Equatable {
  const VerifyAccountState();
  
  @override
  List<Object> get props => [];
}

class VerifyAccountInitial extends VerifyAccountState {}
