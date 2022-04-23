import 'package:equatable/equatable.dart';

class Setting extends Equatable {
  final String termsAndCondition, privacyPolicy, aboutUs;

  const Setting({
    required this.termsAndCondition,
    required this.privacyPolicy,
    required this.aboutUs,
  });

  @override
  List<Object?> get props => [termsAndCondition, privacyPolicy, aboutUs];
}
