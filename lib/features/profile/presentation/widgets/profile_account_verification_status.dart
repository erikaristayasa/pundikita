import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../../../core/domain/entities/user_entity.dart';
import '../../../../core/presentation/widgets/account_verification.dart';
import '../../../../core/presentation/widgets/rounded_container.dart';
import '../../../../core/routes/path.dart';
import '../../../../core/static/assets.dart';
import '../../../../core/utility/helper.dart';
import '../bloc/profile_bloc.dart';
import 'profile_menu.dart';

class ProfileAccountVerificationStatus extends StatelessWidget {
  const ProfileAccountVerificationStatus({Key? key}) : super(key: key);

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
            asset: Assets.ACCOUNT_VERIFICATION,
            onTap: () {
              if (getAccountVerificationStatus(_data)) {
                Fluttertoast.showToast(msg: "Akun anda telah terverifikasi.");
              } else {
                Navigator.pushNamed(context, PROFILE_ACCOUNT_VERIFICATION);
              }
            },
            title: 'Status akun Anda',
            subtitleWidget: AccountVerificationField(user: _data),
          ),
        );
      },
    );
  }
}
