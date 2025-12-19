import 'package:flutter/material.dart';
import 'package:pui_bhasbi_mobile/common/theme/app_theme.dart';
import 'package:pui_bhasbi_mobile/features/auth/presentation/pages/login_screen.dart';
import 'package:pui_bhasbi_mobile/features/auth/presentation/pages/register_screen.dart';

class AuthPages extends StatefulWidget {
  const AuthPages({super.key});

  @override
  State<AuthPages> createState() => _AuthPagesState();
}

class _AuthPagesState extends State<AuthPages> {
  // true = Login, false = Register
  bool _showLogin = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: _showLogin
                    ? const LoginScreen()
                    : RegisterScreen(
                        onRegisterSuccess: () {
                          setState(() {
                            _showLogin = true;
                          });
                        },
                      ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 24.0, top: 16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    _showLogin ? "Belum punya akun? " : "Sudah punya akun? ",
                    style: AppTheme.body.copyWith(color: Colors.black87),
                  ),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        _showLogin = !_showLogin;
                      });
                    },
                    child: Text(
                      _showLogin ? "Buat akun" : "Masuk",
                      style: AppTheme.body.copyWith(
                        color: const Color(0xFF0077C0),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
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
