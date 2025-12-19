import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pui_bhasbi_mobile/common/bloc/auth/auth_cubit.dart';
import 'package:pui_bhasbi_mobile/common/bloc/auth/auth_state.dart';
import 'package:pui_bhasbi_mobile/common/theme/app_theme.dart';
import 'package:pui_bhasbi_mobile/common/widget/custom_button.dart';
import 'package:pui_bhasbi_mobile/features/report/presentation/pages/my_reports.dart'; // NEW

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  void initState() {
    super.initState();
    context.read<AuthStateCubit>().refreshProfile();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50], // Lighter background
      body: BlocBuilder<AuthStateCubit, AuthState>(
        builder: (context, state) {
          if (state is Authenticated) {
            final user = state.user;
            return SingleChildScrollView(
              child: Column(
                children: [
                  // HEADER Custom
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.fromLTRB(24, 60, 24, 30),
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(30),
                        bottomRight: Radius.circular(30),
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black12,
                          blurRadius: 10,
                          offset: Offset(0, 5),
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        // Avatar
                        Container(
                          width: 100,
                          height: 100,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.grey.shade200,
                            border: Border.all(
                              color: Colors.blue.shade100,
                              width: 3,
                            ),
                          ),
                          child: ClipOval(
                            child:
                                user.avatarUrl != null &&
                                    user.avatarUrl!.isNotEmpty
                                ? Image.network(
                                    user.avatarUrl!,
                                    fit: BoxFit.cover,
                                    errorBuilder:
                                        (context, error, stackTrace) => Center(
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
                        const SizedBox(height: 16),
                        Text(
                          user.name ?? "No Name",
                          style: AppTheme.title.copyWith(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          user.email ?? "No Email",
                          style: AppTheme.body.copyWith(color: Colors.grey),
                        ),
                        const SizedBox(height: 16),
                        // Stats Mockup (Optional, based on "percantik UI")
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 8,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.blue.shade50,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Text(
                            "Role: ${user.role ?? 'USER'}",
                            style: TextStyle(
                              color: Colors.blue.shade700,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),

                  // MENU LIST
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24.0),
                    child: Column(
                      children: [
                        _buildMenuTile(
                          icon: Icons.history_edu,
                          title: "Riwayat Laporan Saya",
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const MyReportsPage(),
                              ),
                            );
                          },
                        ),
                        const SizedBox(height: 16),
                        _buildMenuTile(
                          // Placeholder for future features
                          icon: Icons.person_outline,
                          title: "Edit Profil",
                          onTap: () {
                            // TODO: Implement Edit Profile
                          },
                        ),
                        const SizedBox(height: 16),
                        _buildMenuTile(
                          icon: Icons.settings_outlined,
                          title: "Pengaturan Aplikasi",
                          onTap: () {},
                        ),
                        const SizedBox(height: 32),
                        CustomButton(
                          text: 'Keluar',
                          onPressed: () {
                            context.read<AuthStateCubit>().logout();
                          },
                          backgroundColor: Colors.red.shade50,
                          textColor: Colors.red,
                        ),
                        const SizedBox(height: 32),
                      ],
                    ),
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

  Widget _buildMenuTile({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: ListTile(
        leading: Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Colors.blue.shade50,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(icon, color: Colors.blue.shade700),
        ),
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.w600)),
        trailing: const Icon(Icons.chevron_right, color: Colors.grey),
        onTap: onTap,
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      ),
    );
  }
}
