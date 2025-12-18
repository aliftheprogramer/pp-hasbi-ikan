import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pui_bhasbi_mobile/features/home/presentation/pages/home_page.dart';
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
                  label: 'Home',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.history_rounded),
                  label: 'Activity',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.account_balance_wallet_rounded),
                  label: 'Wallet',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.person_rounded),
                  label: 'Profile',
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
      // TODO: Replace with generic HomePage
      case 1:
        return const Center(child: Text('Activity Page Placeholder'));
      // TODO: Replace with generic ActivityPage
      case 2:
        return const Center(child: Text('Wallet Page Placeholder'));
      // TODO: Replace with generic WalletPage
      case 3:
        return const Center(child: Text('Profile Page Placeholder'));
      // TODO: Replace with generic ProfilePage
      default:
        return const Center(child: Text('Page Not Found'));
    }
  }
}
