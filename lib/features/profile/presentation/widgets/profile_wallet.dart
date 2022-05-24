import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/domain/entities/user_entity.dart';
import '../../../../core/presentation/widgets/rounded_container.dart';
import '../../../../core/routes/path.dart' as path;
import '../../../../core/static/assets.dart';
import '../../../../core/utility/helper.dart';
import '../bloc/profile_bloc.dart';
import 'profile_menu.dart';

class ProfileWallet extends StatelessWidget {
  const ProfileWallet({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileBloc, ProfileState>(
      builder: (context, state) {
        User? _data;
        if (state is ProfileLoaded) {
          _data = state.data;
        }

        return RoundedContainer(
          child: ProfileMenu(
            asset: Assets.WALLET,
            onTap: () => Navigator.pushNamed(context, path.WALLET_TOP_UP),
            title: 'Pundi Kebaikan',
            subtitle: 'Saldo anda saat ini ${getFormattedPrice(_data?.saldo?.toInt() ?? 0)}',
          ),
        );
      },
    );
  }
}
