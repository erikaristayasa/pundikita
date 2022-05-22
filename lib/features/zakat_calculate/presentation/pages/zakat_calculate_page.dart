import 'package:flutter/material.dart';
import 'package:pundi_kita/features/zakat_calculate/presentation/widgets/maal_calculate.dart';

import '../../../../core/presentation/widgets/custom_app_bar.dart';
import '../../../../core/static/assets.dart';
import '../../../../core/static/colors.dart';
import '../widgets/profession_calculate.dart';

class ZakatCalculatePage extends StatefulWidget {
  const ZakatCalculatePage({Key? key}) : super(key: key);

  @override
  State<ZakatCalculatePage> createState() => _ZakatCalculatePageState();
}

class _ZakatCalculatePageState extends State<ZakatCalculatePage> with TickerProviderStateMixin {
  int _selectedIndex = 0;
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(initialIndex: _selectedIndex, length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const CustomAppBar(
        canBack: true,
        title: 'Kalkulator Zakat',
      ),
      body: SafeArea(
        child: Column(
          children: [
            TabBar(
              controller: _tabController,
              indicatorColor: AppColors.PRIMARY,
              onTap: (index) {
                setState(() {
                  _selectedIndex = index;
                });
              },
              tabs: [
                Tab(
                  // text: 'Profesi',
                  child: TextButton.icon(
                    onPressed: null,
                    icon: Image.asset(
                      Assets.PROFESSION,
                      width: 18.0,
                    ),
                    label: Text(
                      'Profesi',
                      style: TextStyle(color: _selectedIndex == 0 ? AppColors.PRIMARY : Colors.grey),
                    ),
                  ),
                ),
                Tab(
                  // text: 'Maal',
                  child: TextButton.icon(
                    onPressed: null,
                    icon: Image.asset(
                      Assets.PROFESSION,
                      width: 18.0,
                    ),
                    label: Text(
                      'Maal',
                      style: TextStyle(color: _selectedIndex == 1 ? AppColors.PRIMARY : Colors.grey),
                    ),
                  ),
                )
              ],
            ),
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: const [
                  ProfessionCalculate(),
                  MaalCalculate(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
