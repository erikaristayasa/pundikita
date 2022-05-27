import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:pundi_kita/features/profile/domain/usecases/update_profile.dart';

import '../../../../core/domain/entities/user_entity.dart';
import '../../../../core/errors/failure.dart';
import '../../../../core/domain/usecases/get_profile.dart';

part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final GetProfile getProfile;
  final UpdateProfile updateProfile;
  ProfileBloc({
    required this.getProfile,
    required this.updateProfile,
  }) : super(ProfileInitial()) {
    on<FetchProfile>((event, emit) async {
      emit(ProfileLoading());

      final result = await getProfile();
      result.fold(
        (failure) => emit(ProfileFailure(failure: failure)),
        (data) => emit(ProfileLoaded(data: data)),
      );
    });

    on<SubmitUpdate>((event, emit) async {
      emit(ProfileUpdating());

      final result = await updateProfile(event.data);
      result.fold(
        (failure) => emit(ProfileFailure(failure: failure)),
        (_) => emit(ProfileUpdated()),
      );
    });

    on<SubmitVerificationData>((event, emit) async {
      emit(ProfileUpdating());

      final formData = FormData.fromMap(event.map);

      final result = await updateProfile(formData);
      result.fold(
        (failure) => emit(ProfileFailure(failure: failure)),
        (_) => emit(ProfileUpdated()),
      );
    });
  }
}
