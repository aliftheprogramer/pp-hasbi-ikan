import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pui_bhasbi_mobile/common/bloc/auth/auth_cubit.dart';
import 'package:pui_bhasbi_mobile/common/theme/app_theme.dart';
import 'package:pui_bhasbi_mobile/common/widget/custom_button.dart';
import 'package:pui_bhasbi_mobile/common/widget/text_form_field_custom.dart';
import 'package:pui_bhasbi_mobile/features/auth/domain/entity/login_request_entity.dart';
import 'package:pui_bhasbi_mobile/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:pui_bhasbi_mobile/features/auth/presentation/bloc/auth_event.dart';
import 'package:pui_bhasbi_mobile/features/auth/presentation/bloc/auth_state.dart'
    as bloc;

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _onLogin() {
    final email = _emailController.text;
    final password = _passwordController.text;

    if (email.isNotEmpty && password.isNotEmpty) {
      context.read<AuthBloc>().add(
        LoginEvent(LoginRequestEntity(email: email, password: password)),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Email dan Password harus diisi")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, bloc.AuthState>(
      listener: (context, state) {
        if (state is bloc.AuthSuccess) {
          // Trigger global auth refresh to navigate to Home
          context.read<AuthStateCubit>().appStarted();
        } else if (state is bloc.AuthFailure) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(state.error as String)));
        }
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 40),
            Text(
              "Selamat Datang Kembali",
              style: AppTheme.title.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              "Silahkan masuk untuk melanjutkan",
              style: AppTheme.subtitle.copyWith(color: Colors.grey),
            ),
            const SizedBox(height: 32),
            CustomTextFormField(
              label: "Email",
              hintText: "Contoh: hasbi12@gmail.com",
              keyboardType: TextInputType.emailAddress,
              controller: _emailController,
            ),
            const SizedBox(height: 20),
            CustomTextFormField(
              label: "Kata Sandi",
              isPassword: true,
              controller: _passwordController,
            ),
            const SizedBox(height: 12),
            Align(
              alignment: Alignment.centerLeft,
              child: GestureDetector(
                onTap: () {
                  // TODO: Handle Forgot Password
                },
                child: Text(
                  "Lupa Kata Sandi?",
                  style: AppTheme.body.copyWith(
                    color: const Color(0xFF0077C0),
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 32),
            BlocBuilder<AuthBloc, bloc.AuthState>(
              builder: (context, state) {
                return CustomButton(
                  text: "Masuk",
                  isLoading: state is bloc.AuthLoading,
                  onPressed: _onLogin,
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
