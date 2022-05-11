import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/entities/user_entity.dart';
import '../../domain/usecases/get_profile.dart';

class UserInfoCubit extends Cubit<User?> {
  final GetProfile getProfile;
  UserInfoCubit({required this.getProfile}) : super(null);

  Future<void> getData() async {
    final result = await getProfile();
    result.fold((l) => emit(null), (r) => emit(r));
  }
}
