import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pui_bhasbi_mobile/common/theme/app_theme.dart';
import 'package:pui_bhasbi_mobile/features/home/domain/entity/fish_entity.dart';
import 'package:pui_bhasbi_mobile/features/home/presentation/bloc/fish_cubit.dart';
import 'package:pui_bhasbi_mobile/features/home/presentation/bloc/fish_state.dart';
import 'package:pui_bhasbi_mobile/features/home/presentation/pages/danger_fish_list_page.dart';
import 'package:pui_bhasbi_mobile/features/home/presentation/pages/detail_danger_fish.dart';

class AncamanSungai extends StatelessWidget {
  const AncamanSungai({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Kenali Ancaman Sungai",
                style: AppTheme.title.copyWith(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              GestureDetector(
                onTap: () {
                  // Capture the cubit from the current context before navigating
                  final fishCubit = context.read<FishCubit>();
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => BlocProvider.value(
                        value: fishCubit,
                        child: const DangerFishListPage(),
                      ),
                    ),
                  );
                },
                child: Text(
                  "Lihat semua",
                  style: AppTheme.subtitle.copyWith(color: Colors.blue),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),
        BlocBuilder<FishCubit, FishState>(
          builder: (context, state) {
            if (state is FishLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is FishLoaded) {
              final list = state.fishList.take(3).toList();
              return ListView.separated(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: list.length,
                separatorBuilder: (context, index) =>
                    const SizedBox(height: 16),
                itemBuilder: (context, index) {
                  return FishCardItem(fish: list[index]);
                },
              );
            } else if (state is FishError) {
              return Center(child: Text(state.message));
            }
            return const SizedBox();
          },
        ),
      ],
    );
  }
}

class FishCardItem extends StatelessWidget {
  final FishEntity fish;
  const FishCardItem({super.key, required this.fish});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (fish.id != null) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => DetailDangerFishPage(fishId: fish.id!),
            ),
          );
        }
      },
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              offset: const Offset(0, 4),
              blurRadius: 10,
            ),
          ],
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                color: const Color(0xFFEBF6FF), // Light blue background
                borderRadius: BorderRadius.circular(8),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.network(
                  fish.imageUrl ?? "",
                  fit: BoxFit.contain, // Changed to contain to show full fish
                  errorBuilder: (context, error, stackTrace) =>
                      const Icon(Icons.broken_image, color: Colors.grey),
                ),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    fish.name ?? "Unknown",
                    style: AppTheme.title.copyWith(fontSize: 16),
                  ),
                  if (fish.scientificName != null)
                    Text(
                      fish.scientificName!,
                      style: AppTheme.subtitle.copyWith(
                        color: Colors.blue,
                        fontStyle: FontStyle.italic,
                        fontSize: 12,
                      ),
                    ),
                  const SizedBox(height: 4),
                  Text(
                    fish.description ?? "",
                    style: AppTheme.body.copyWith(
                      color: Colors.grey.shade600,
                      fontSize: 12,
                    ),
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
