import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../features/home/presentation/pages/home_page.dart';
import '../../../features/profile/presentation/pages/profile_page.dart';
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
      body: BlocBuilder<NavbarCubit, int>(
        bloc: navbar,
        builder: (context, state) {
          if (state == 0) {
            return const HomePage();
          } else {
            return const ProfilePage();
          }
        },
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
            selectedItemColor: Colors.black,
            unselectedItemColor: Colors.black45,
            onTap: navbar.change,
            iconSize: 26,
            items: const [
              BottomNavigationBarItem(
                label: 'Home',
                icon: Icon(Icons.home_rounded),
              ),
              BottomNavigationBarItem(
                label: 'Galang Dana',
                icon: Icon(Icons.handshake_rounded),
              ),
              BottomNavigationBarItem(
                label: 'Donasi Saya',
                icon: Icon(Icons.list_alt_rounded),
              ),
              BottomNavigationBarItem(
                label: 'Inbox',
                icon: Icon(Icons.email_rounded),
              ),
              BottomNavigationBarItem(
                label: 'Profile',
                icon: Icon(Icons.person_rounded),
              )
            ],
          );
        },
      ),
    );
  }
}
