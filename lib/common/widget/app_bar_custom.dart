import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pui_bhasbi_mobile/common/bloc/auth/auth_cubit.dart';
import 'package:pui_bhasbi_mobile/common/bloc/auth/auth_state.dart';
import 'package:pui_bhasbi_mobile/common/theme/app_theme.dart';

class AppBarCustom extends StatelessWidget implements PreferredSizeWidget {
  final String? title; // NEW

  const AppBarCustom({super.key, this.title}); // NEW

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      centerTitle: true,
      leadingWidth: 70, // Adjust width to fit avatar with padding
      leading: Padding(
        padding: const EdgeInsets.only(left: 24.0),
        child: BlocBuilder<AuthStateCubit, AuthState>(
          builder: (context, state) {
            if (state is Authenticated) {
              final user = state.user;
              // Avatar Logic
              if (user.avatarUrl != null && user.avatarUrl!.isNotEmpty) {
                return CircleAvatar(
                  radius: 20,
                  backgroundImage: NetworkImage(user.avatarUrl!),
                );
              } else {
                return CircleAvatar(
                  radius: 20,
                  backgroundColor: Colors.grey.shade300,
                  child: Text(
                    user.name != null && user.name!.isNotEmpty
                        ? user.name![0].toUpperCase()
                        : "A",
                    style: AppTheme.title.copyWith(
                      color: Colors.white,
                      fontSize: 18,
                    ),
                  ),
                );
              }
            }
            return const SizedBox();
          },
        ),
      ),
      title:
          title !=
              null // NEW LOGIC
          ? Text(title!, style: AppTheme.appBarTitle)
          : BlocBuilder<AuthStateCubit, AuthState>(
              builder: (context, state) {
                if (state is Authenticated) {
                  final user = state.user;
                  return Column(
                    mainAxisSize: MainAxisSize.min, // Shrink to fit children
                    children: [
                      Text(
                        "Selamat Datang",
                        style: AppTheme.subtitle.copyWith(
                          color: Colors.grey.shade600,
                          fontSize: 12,
                        ),
                      ),
                      const SizedBox(height: 5),
                      Text(
                        user.name?.split(' ').first ?? 'User',
                        style: AppTheme.appBarTitle,
                      ),
                    ],
                  );
                }
                return const SizedBox();
              },
            ),
      actions: [
        Padding(
          padding: const EdgeInsets.only(right: 24.0),
          child: Stack(
            alignment: Alignment.center,
            children: [
              const Icon(
                Icons.notifications_outlined,
                color: Colors.black,
                size: 28,
              ),
              Positioned(
                top: 10,
                right: 2,
                child: Container(
                  height: 8,
                  width: 8,
                  decoration: const BoxDecoration(
                    color: Colors.red,
                    shape: BoxShape.circle,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight + 10);
}
