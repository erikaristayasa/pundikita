import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../../core/domain/usecases/like_unlike.dart';

part 'aamin_event.dart';
part 'aamin_state.dart';

class AaminBloc extends Bloc<AaminEvent, AaminState> {
  final DoLike doLike;
  final DoUnLike doUnLike;
  AaminBloc({
    required this.doLike,
    required this.doUnLike,
  }) : super(const AaminInitial(false)) {
    on<Initial>((event, emit) => emit(AaminInitial(event.likeStatus)));
    on<LikeUnlike>((event, emit) async {
      emit(AaminLoading(state.status));

      if (state.status) {
        // do unlike
        await doUnLike(donationId: event.donationId).then((ok) {
          if (ok) {
            emit(const AaminUnliked(false)); // unlike
          } else {
            emit(AaminInitial(state.status));
          }
        });
      } else {
        // do like
        await doLike(donationId: event.donationId).then((ok) {
          if (ok) {
            emit(const AaminLiked(true)); // like
          } else {
            emit(AaminInitial(state.status));
          }
        });
      }
    });
  }
}
