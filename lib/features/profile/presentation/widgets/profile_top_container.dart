import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/domain/entities/user_entity.dart';
import '../../../../core/presentation/widgets/rounded_button.dart';
import '../../../../core/static/colors.dart';
import '../../../../core/static/dimens.dart';
import '../../../../core/static/extensions.dart';
import '../../../../core/utility/app_locale.dart';
import '../../../../core/utility/helper.dart';
import '../bloc/profile_bloc.dart';
import '../../../../core/routes/path.dart' as path;

class ProfileTopContainer extends StatefulWidget {
  const ProfileTopContainer({Key? key}) : super(key: key);

  @override
  State<ProfileTopContainer> createState() => _ProfileTopContainerState();
}

class _ProfileTopContainerState extends State<ProfileTopContainer> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.all(Dimension.MEDIUM),
      height: 110,
      child: BlocBuilder<ProfileBloc, ProfileState>(
        builder: (context, state) {
          User? _data;
          if (state is ProfileLoaded) {
            _data = state.data;
          }
          return Row(
            children: [
              AspectRatio(
                aspectRatio: 1 / 1,
                child: CircleAvatar(
                  foregroundImage: NetworkImage(getUserImageUrl(_data?.photo ?? "")),
                  backgroundColor: AppColors.SECONDARY.withOpacity(0.15),
                ),
              ),
              mediumHorizontalSpacing(),
              Expanded(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      _data?.name ?? '',
                      style: context.textTheme().headline6,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    RoundedButton(
                      width: 100.0,
                      height: 30.0,
                      outline: true,
                      onTap: () => Navigator.pushNamed(context, path.PROFILE_UPDATE),
                      title: AppLocale.loc.editProfile,
                      titleColor: AppColors.PRIMARY,
                    ),
                  ],
                ),
              )
            ],
          );
        },
      ),
    );
  }
}
