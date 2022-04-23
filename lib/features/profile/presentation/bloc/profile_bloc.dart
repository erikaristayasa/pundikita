import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/domain/entities/user_entity.dart';
import '../../../../core/errors/failure.dart';
import '../../domain/usecases/get_profile.dart';

part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final GetProfile getProfile;
  ProfileBloc({required this.getProfile}) : super(ProfileInitial()) {
    on<FetchProfile>((event, emit) async {
      emit(ProfileLoading());

      final result = await getProfile();
      result.fold(
        (failure) => emit(ProfileFailure(failure: failure)),
        (data) => emit(ProfileLoaded(data: data)),
      );
    });
  }
}
