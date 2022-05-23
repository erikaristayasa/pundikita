import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/presentation/blocs/all_donation/all_donation_bloc.dart';
import '../../../../core/presentation/pages/loading_page.dart';
import '../../../../core/presentation/widgets/donation_list.dart';

class HomeAllDonation extends StatefulWidget {
  const HomeAllDonation({Key? key}) : super(key: key);

  @override
  State<HomeAllDonation> createState() => _HomeAllDonationState();
}

class _HomeAllDonationState extends State<HomeAllDonation> {
  @override
  void initState() {
    super.initState();
    context.read<AllDonationBloc>().add(FetchData());
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AllDonationBloc, AllDonationState>(
      builder: (context, state) {
        if (state is AllDonationLoading) {
          return const LoadingPage(isList: true);
        } else if (state is AllDonationLoaded) {
          return DonationList(
            donations: state.data,
            labelText: "Do'a-doa#Kebaikan",
          );
        }
        return const SizedBox.shrink();
      },
    );
  }
}
