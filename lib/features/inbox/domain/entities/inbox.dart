import 'package:equatable/equatable.dart';

class Inbox extends Equatable {
  final int id;
  final String? photo, title, description;

  const Inbox({
    required this.id,
    required this.photo,
    required this.title,
    required this.description,
  });

  @override
  List<Object?> get props => [
        id,
        photo,
        title,
        description,
      ];
}
