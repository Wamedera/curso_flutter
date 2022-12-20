import 'package:flutter/material.dart';

import '../tabs/home_tab.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  final _pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return PageView(
      physics: NeverScrollableScrollPhysics(),
      children: [
        HomeTab(),
      ],
    );
  }
}
