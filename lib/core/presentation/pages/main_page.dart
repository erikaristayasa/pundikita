import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../static/assets.dart';
import '../cubits/navbar_cubit.dart';
import '../widgets/navbar_icon.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> with TickerProviderStateMixin {
  late AnimationController _homeController;
  late AnimationController _profileController;
  final navbar = NavbarCubit(0);

  @override
  void initState() {
    super.initState();
    _homeController = AnimationController(vsync: this, duration: const Duration(seconds: 2));
    _profileController = AnimationController(vsync: this, duration: const Duration(seconds: 2));
  }

  @override
  void dispose() {
    _homeController.dispose();
    _profileController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // void onChanged(int i) {}

    return Scaffold(
      body: SafeArea(
        child: Container(
          height: double.maxFinite,
          width: double.maxFinite,
          color: Colors.teal,
        ),
      ),
      bottomNavigationBar: BlocConsumer<NavbarCubit, int>(
        bloc: navbar,
        listener: (context, state) {
          if (state == 0) {
            _homeController.reset();
            _homeController.forward();
          } else {
            _profileController.reset();
            _profileController.forward();
          }
        },
        builder: (context, state) {
          return BottomNavigationBar(
            currentIndex: state,
            unselectedFontSize: 12.0,
            selectedFontSize: 12.0,
            onTap: navbar.change,
            items: [
              BottomNavigationBarItem(
                label: 'Home',
                icon: NavbarIcon(
                  asset: Assets.LOTTIE_HOME,
                  controller: _homeController,
                ),
              ),
              BottomNavigationBarItem(
                label: 'Profile',
                icon: NavbarIcon(
                  asset: Assets.LOTTIE_PROFILE,
                  controller: _profileController,
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
