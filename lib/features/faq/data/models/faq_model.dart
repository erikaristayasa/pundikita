import '../../domain/entities/faq_entity.dart';

class FaqResponseModel {
  final int status;
  final List<FaqModel> data;

  FaqResponseModel({required this.status, required this.data});

  factory FaqResponseModel.fromJson(Map<String, dynamic> json) => FaqResponseModel(
        status: json['status'],
        data: List<FaqModel>.from(json['data'].map((x) => FaqModel.fromJson(x))),
      );
}

class FaqModel extends Faq {
  const FaqModel({
    required int id,
    required String question,
    required String answers,
  }) : super(
          id: id,
          question: question,
          answers: answers,
        );
  factory FaqModel.fromJson(Map<String, dynamic> json) => FaqModel(
        id: json['id'],
        question: json['pertanyaan'] ?? '',
        answers: json['jawaban'] ?? '',
      );
}
