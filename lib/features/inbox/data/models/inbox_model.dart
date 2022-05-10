import '../../domain/entities/inbox.dart';

class InboxModel extends Inbox {
  const InboxModel({
    required int id,
    required String? photo,
    required String? title,
    required String? description,
  }) : super(
          id: id,
          photo: photo,
          title: title,
          description: description,
        );

  factory InboxModel.fromJson(Map<String, dynamic> json) => InboxModel(
        id: json['id'],
        photo: json['foto'],
        title: json['judul'],
        description: json['deskripsi'],
      );
}
