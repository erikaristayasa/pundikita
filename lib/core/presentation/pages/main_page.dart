import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../features/home/presentation/pages/home_page.dart';
import '../../../features/profile/presentation/pages/profile_page.dart';
import '../../static/colors.dart';
import '../../utility/app_locale.dart';
import '../cubits/navbar_cubit.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final navbar = NavbarCubit(0);

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: BlocBuilder<NavbarCubit, int>(
          bloc: navbar,
          builder: (context, state) {
            if (state == 0) {
              return const HomePage();
            } else {
              return const ProfilePage();
            }
          },
        ),
      ),
      bottomNavigationBar: BlocBuilder<NavbarCubit, int>(
        bloc: navbar,
        builder: (context, state) {
          return BottomNavigationBar(
            type: BottomNavigationBarType.shifting,
            currentIndex: state,
            backgroundColor: Colors.white,
            unselectedFontSize: 10.0,
            selectedFontSize: 12.0,
            selectedItemColor: AppColors.PRIMARY,
            unselectedItemColor: Colors.black45,
            onTap: navbar.change,
            iconSize: 26,
            items: [
              BottomNavigationBarItem(
                label: AppLocale.loc.home,
                icon: const Icon(Icons.home_rounded),
              ),
              BottomNavigationBarItem(
                label: AppLocale.loc.raiseFunds,
                icon: const Icon(Icons.handshake_rounded),
              ),
              BottomNavigationBarItem(
                label: AppLocale.loc.myDonation,
                icon: const Icon(Icons.list_alt_rounded),
              ),
              BottomNavigationBarItem(
                label: AppLocale.loc.inbox,
                icon: const Icon(Icons.email_rounded),
              ),
              BottomNavigationBarItem(
                label: AppLocale.loc.profile,
                icon: const Icon(Icons.person_rounded),
              )
            ],
          );
        },
      ),
    );
  }
}
