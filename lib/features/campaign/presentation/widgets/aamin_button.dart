import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../../../core/utility/app_locale.dart';
import '../../../../core/utility/locator.dart';
import '../bloc/aamin/aamin_bloc.dart';

class AaminButton extends StatefulWidget {
  final int donationId;
  final bool likeStatus;
  const AaminButton({
    Key? key,
    required this.likeStatus,
    required this.donationId,
  }) : super(key: key);

  @override
  State<AaminButton> createState() => _AaminButtonState();
}

class _AaminButtonState extends State<AaminButton> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => locator<AaminBloc>()..add(Initial(likeStatus: widget.likeStatus)),
      child: BlocConsumer<AaminBloc, AaminState>(
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
                  context.read<AaminBloc>().add(LikeUnlike(donationId: widget.donationId));
                },
                icon: Icon(state.status ? Icons.favorite_rounded : Icons.favorite_border_rounded),
                label: Text(AppLocale.loc.aamiin),
              );
          }
        },
      ),
    );
  }
}
