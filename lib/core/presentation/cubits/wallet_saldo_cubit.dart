import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pundi_kita/core/domain/usecases/get_profile.dart';

class WalletSaldoCubit extends Cubit<num> {
  final GetProfile getProfile;
  WalletSaldoCubit({required this.getProfile}) : super(0);

  Future<void> getSaldo() async {
    final result = await getProfile();
    result.fold(
      (l) => emit(0),
      (r) => emit(r.saldo ?? 0),
    );
  }
}
