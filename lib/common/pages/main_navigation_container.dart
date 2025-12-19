import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pui_bhasbi_mobile/features/auth/presentation/pages/profile_page.dart';
import 'package:pui_bhasbi_mobile/features/home/presentation/pages/home_page.dart';
import 'package:pui_bhasbi_mobile/features/report/presentation/pages/information_pages.dart';
import 'package:pui_bhasbi_mobile/features/report/presentation/pages/report_page.dart';
import '../bloc/nav/nav_cubit.dart';

class MainNavigationContainer extends StatelessWidget {
  const MainNavigationContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NavigationCubit, int>(
      builder: (context, state) {
        return Scaffold(
          body: _buildPage(state),
          bottomNavigationBar: Container(
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.1),
                  spreadRadius: 1,
                  blurRadius: 10,
                  offset: const Offset(0, -1),
                ),
              ],
            ),
            child: BottomNavigationBar(
              currentIndex: state,
              onTap: (index) {
                context.read<NavigationCubit>().updateIndex(index);
              },
              items: const [
                BottomNavigationBarItem(
                  icon: Icon(Icons.home_rounded),
                  label: 'Beranda',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.report),
                  label: 'Lapor',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.book),
                  label: 'Informasi',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.person_rounded),
                  label: 'Profil',
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildPage(int index) {
    switch (index) {
      case 0:
        return const HomePage();
      case 1:
        return const ReportPage();
      case 2:
        return const InformationPage();
      case 3:
        return const ProfilePage();
      default:
        return const Center(child: Text('Page Not Found'));
    }
  }
}
