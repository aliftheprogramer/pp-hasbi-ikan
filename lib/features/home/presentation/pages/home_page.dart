import 'package:flutter/material.dart';
import 'package:pui_bhasbi_mobile/common/widget/app_bar_custom.dart';
import 'package:pui_bhasbi_mobile/features/home/presentation/widgets/home_carousel.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: AppBarCustom(),
      body: Column(children: [SizedBox(height: 24), HomeCarousel()]),
    );
  }
}
