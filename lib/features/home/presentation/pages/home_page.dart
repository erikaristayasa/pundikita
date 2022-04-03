import 'package:flutter/material.dart';

import '../widgets/search_bar.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: SearchBar(),
      body: SafeArea(
        child: ColoredBox(
          color: Colors.red,
          child: SizedBox.expand(),
        ),
      ),
    );
  }
}
