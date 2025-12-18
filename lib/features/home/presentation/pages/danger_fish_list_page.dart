import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pui_bhasbi_mobile/common/theme/app_theme.dart';
import 'package:pui_bhasbi_mobile/features/home/presentation/bloc/fish_cubit.dart';
import 'package:pui_bhasbi_mobile/features/home/presentation/bloc/fish_state.dart';
import '../widgets/ancaman_sungai.dart'; // Will reuse card item if possible, or define here

class DangerFishListPage extends StatelessWidget {
  const DangerFishListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Ancaman Sungai", style: AppTheme.appBarTitle),
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: BlocBuilder<FishCubit, FishState>(
        builder: (context, state) {
          if (state is FishLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is FishLoaded) {
            return ListView.separated(
              padding: const EdgeInsets.all(24),
              itemCount: state.fishList.length,
              separatorBuilder: (context, index) => const SizedBox(height: 16),
              itemBuilder: (context, index) {
                final fish = state.fishList[index];
                return FishCardItem(fish: fish);
              },
            );
          } else if (state is FishError) {
            return Center(child: Text(state.message));
          }
          return const SizedBox();
        },
      ),
    );
  }
}
