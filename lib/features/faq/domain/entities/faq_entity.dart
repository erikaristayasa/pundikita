import 'package:equatable/equatable.dart';

class Faq extends Equatable {
  final int id;
  final String question, answers;

  const Faq({
    required this.id,
    required this.question,
    required this.answers,
  });

  @override
  List<Object?> get props => [id, question, answers];
}
