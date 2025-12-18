import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pui_bhasbi_mobile/common/theme/app_theme.dart';
import 'package:pui_bhasbi_mobile/core/services/service_locator.dart';
import 'package:pui_bhasbi_mobile/features/home/presentation/bloc/fish_detail_cubit.dart';
import 'package:pui_bhasbi_mobile/features/home/presentation/bloc/fish_detail_state.dart';

class DetailDangerFishPage extends StatelessWidget {
  final String fishId;

  const DetailDangerFishPage({super.key, required this.fishId});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<FishDetailCubit>()..getFishDetail(fishId),
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: Container(
            margin: const EdgeInsets.only(left: 16, top: 8, bottom: 8),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.8),
              shape: BoxShape.circle,
            ),
            child: IconButton(
              icon: const Icon(Icons.arrow_back, color: Colors.black),
              onPressed: () => Navigator.pop(context),
            ),
          ),
          flexibleSpace: Container(), // Can be used for gradient if needed
        ),
        extendBodyBehindAppBar: true,
        body: BlocBuilder<FishDetailCubit, FishDetailState>(
          builder: (context, state) {
            if (state is FishDetailLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is FishDetailFailure) {
              return Center(child: Text(state.message));
            } else if (state is FishDetailSuccess) {
              final fish = state.fish;
              return SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Header Image
                    Container(
                      width: double.infinity,
                      height: 300,
                      decoration: BoxDecoration(
                        color: const Color(0xFFEBF6FF),
                        borderRadius: const BorderRadius.only(
                          bottomLeft: Radius.circular(32),
                          bottomRight: Radius.circular(32),
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(40.0),
                        child: Image.network(
                          fish.imageUrl ?? "",
                          fit: BoxFit.contain,
                          errorBuilder: (context, error, stackTrace) =>
                              const Icon(
                                Icons.broken_image,
                                size: 50,
                                color: Colors.grey,
                              ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 24),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Text(
                                  fish.name ?? "Unknown Fish",
                                  style: AppTheme.title.copyWith(
                                    fontSize: 24,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              if (fish.dangerLevel != null)
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 12,
                                    vertical: 6,
                                  ),
                                  decoration: BoxDecoration(
                                    color: Colors.red.withOpacity(0.1),
                                    borderRadius: BorderRadius.circular(20),
                                    border: Border.all(
                                      color: Colors.red.withOpacity(0.5),
                                    ),
                                  ),
                                  child: Text(
                                    fish.dangerLevel!,
                                    style: AppTheme.subtitle.copyWith(
                                      color: Colors.red,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 12,
                                    ),
                                  ),
                                ),
                            ],
                          ),
                          const SizedBox(height: 8),
                          if (fish.scientificName != null)
                            Text(
                              fish.scientificName!,
                              style: AppTheme.subtitle.copyWith(
                                color: Colors.blue,
                                fontStyle: FontStyle.italic,
                                fontSize: 16,
                              ),
                            ),
                          const SizedBox(height: 24),
                          Text(
                            "Deskripsi",
                            style: AppTheme.title.copyWith(fontSize: 18),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            fish.description ?? "No description available.",
                            style: AppTheme.body.copyWith(
                              color: Colors.grey.shade700,
                              fontSize: 14,
                              height: 1.5,
                            ),
                          ),
                          const SizedBox(height: 32),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            }
            return const SizedBox();
          },
        ),
      ),
    );
  }
}
