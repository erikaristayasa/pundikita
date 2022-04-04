import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../features/home/presentation/pages/home_page.dart';
import '../../../features/profile/presentation/pages/profile_page.dart';
import '../../static/assets.dart';
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
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
        statusBarColor: AppColors.PRIMARY,
      ),
      child: Scaffold(
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
              items: [
                BottomNavigationBarItem(
                  label: AppLocale.loc.home,
                  icon: NavBarIcon(selected: state == 0, asset: Assets.NAV_HOME),
                ),
                BottomNavigationBarItem(
                  label: AppLocale.loc.raiseFunds,
                  icon: NavBarIcon(selected: state == 1, asset: Assets.NAV_DONATION),
                ),
                BottomNavigationBarItem(
                  label: AppLocale.loc.myDonation,
                  icon: NavBarIcon(selected: state == 2, asset: Assets.NAV_MY_DONATION),
                ),
                BottomNavigationBarItem(
                  label: AppLocale.loc.inbox,
                  icon: NavBarIcon(selected: state == 3, asset: Assets.NAV_INBOX),
                ),
                BottomNavigationBarItem(
                  label: AppLocale.loc.profile,
                  icon: NavBarIcon(selected: state == 4, asset: Assets.NAV_PROFILE),
                )
              ],
            );
          },
        ),
      ),
    );
  }
}

class NavBarIcon extends StatelessWidget {
  final bool selected;
  final String asset;
  const NavBarIcon({
    Key? key,
    required this.selected,
    required this.asset,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      backgroundColor: AppColors.SECONDARY.withOpacity(selected ? 0.15 : 0.0),
      child: Image.asset(
        asset,
        width: 24,
      ),
    );
  }
}
