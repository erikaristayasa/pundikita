import 'package:equatable/equatable.dart';

class Banner extends Equatable {
  final int id;
  final int? campaingId;
  final String photo;

  const Banner({
    required this.id,
    required this.campaingId,
    required this.photo,
  });

  @override
  List<Object?> get props => [
        id,
        campaingId,
        photo,
      ];
}
