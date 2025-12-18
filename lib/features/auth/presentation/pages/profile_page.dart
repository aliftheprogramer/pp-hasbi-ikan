import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pui_bhasbi_mobile/common/bloc/auth/auth_cubit.dart';
import 'package:pui_bhasbi_mobile/common/bloc/auth/auth_state.dart';
import 'package:pui_bhasbi_mobile/common/theme/app_theme.dart';
import 'package:pui_bhasbi_mobile/common/widget/custom_button.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text("Profil", style: AppTheme.appBarTitle),
        centerTitle: true,
      ),
      body: BlocBuilder<AuthStateCubit, AuthState>(
        builder: (context, state) {
          if (state is Authenticated) {
            final user = state.user;
            return Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                children: [
                  const SizedBox(height: 20),
                  // Avatar
                  Center(
                    child: Container(
                      width: 120,
                      height: 120,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.grey.shade200,
                        border: Border.all(color: Colors.white, width: 4),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            blurRadius: 10,
                            offset: const Offset(0, 5),
                          ),
                        ],
                      ),
                      child: ClipOval(
                        child:
                            user.avatarUrl != null && user.avatarUrl!.isNotEmpty
                            ? Image.network(
                                user.avatarUrl!,
                                fit: BoxFit.cover,
                                errorBuilder: (context, error, stackTrace) =>
                                    Center(
                                      child: Text(
                                        user.name?.isNotEmpty == true
                                            ? user.name![0].toUpperCase()
                                            : "U",
                                        style: AppTheme.title.copyWith(
                                          fontSize: 40,
                                          color: Colors.grey.shade500,
                                        ),
                                      ),
                                    ),
                              )
                            : Center(
                                child: Text(
                                  user.name?.isNotEmpty == true
                                      ? user.name![0].toUpperCase()
                                      : "U",
                                  style: AppTheme.title.copyWith(
                                    fontSize: 40,
                                    color: Colors.grey.shade500,
                                  ),
                                ),
                              ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),
                  // Name
                  Text(
                    user.name ?? "No Name",
                    style: AppTheme.title.copyWith(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  // Email
                  Text(
                    user.email ?? "No Email",
                    style: AppTheme.body.copyWith(color: Colors.grey),
                  ),
                  const SizedBox(height: 48),

                  // Logout Button
                  CustomButton(
                    text: 'Keluar',
                    onPressed: () {
                      context.read<AuthStateCubit>().logout();
                    },
                    backgroundColor: Colors.red.shade50,
                    textColor: Colors.red,
                  ),
                ],
              ),
            );
          }
          return const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}
