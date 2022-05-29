import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:pundi_kita/core/utility/helper.dart';

import '../../utility/app_locale.dart';
import '../../utility/locator.dart';
import '../blocs/aamin/aamin_bloc.dart';

class AaminButton extends StatelessWidget {
  final int donationId;
  final bool likeStatus;
  const AaminButton({Key? key, required this.donationId, required this.likeStatus}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    logMe('build');
    final bloc = locator<AaminBloc>()..add(Initial(likeStatus: likeStatus));
    return BlocConsumer<AaminBloc, AaminState>(
      bloc: bloc,
      listener: (context, state) {
        if (state is AaminLiked) {
          Fluttertoast.showToast(msg: 'Disukai');
        } else if (state is AaminUnliked) {
          Fluttertoast.showToast(msg: 'Batal disukai');
        }
      },
      builder: (context, state) {
        switch (state.runtimeType) {
          case AaminLoading:
            return const CircularProgressIndicator();
          default:
            return TextButton.icon(
              onPressed: () {
                bloc.add(LikeUnlike(donationId: donationId));
              },
              icon: Icon(state.status ? Icons.favorite_rounded : Icons.favorite_border_rounded),
              label: Text(AppLocale.loc.aamiin),
            );
        }
      },
    );
  }
}
