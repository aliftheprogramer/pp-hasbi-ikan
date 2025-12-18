import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pui_bhasbi_mobile/common/widget/app_bar_custom.dart';
import 'package:pui_bhasbi_mobile/core/services/service_locator.dart';
import 'package:pui_bhasbi_mobile/features/home/presentation/bloc/fish_cubit.dart';
import 'package:pui_bhasbi_mobile/features/home/presentation/widgets/ancaman_sungai.dart';
import 'package:pui_bhasbi_mobile/features/home/presentation/widgets/home_carousel.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<FishCubit>()..getFishList(),
      child: const Scaffold(
        appBar: AppBarCustom(),
        body: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 24),
              HomeCarousel(),
              SizedBox(height: 24),
              AncamanSungai(),
              SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }
}
