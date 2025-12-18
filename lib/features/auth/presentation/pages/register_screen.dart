import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pui_bhasbi_mobile/common/bloc/auth/auth_cubit.dart';
import 'package:pui_bhasbi_mobile/common/theme/app_theme.dart';
import 'package:pui_bhasbi_mobile/common/widget/custom_button.dart';
import 'package:pui_bhasbi_mobile/common/widget/text_form_field_custom.dart';
import 'package:pui_bhasbi_mobile/features/auth/domain/entity/register_request_entity.dart';
import 'package:pui_bhasbi_mobile/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:pui_bhasbi_mobile/features/auth/presentation/bloc/auth_event.dart';
import 'package:pui_bhasbi_mobile/features/auth/presentation/bloc/auth_state.dart'
    as bloc;

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  void _onRegister() {
    final name = _nameController.text;
    final email = _emailController.text;
    final password = _passwordController.text;
    final confirmPassword = _confirmPasswordController.text;

    if (name.isEmpty ||
        email.isEmpty ||
        password.isEmpty ||
        confirmPassword.isEmpty) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text("Semua field harus diisi")));
      return;
    }

    if (password != confirmPassword) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Konfirmasi password tidak cocok")),
      );
      return;
    }

    context.read<AuthBloc>().add(
      RegisterEvent(
        RegisterRequestEntity(name: name, email: email, password: password),
      ),
    );
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
              "Buat Akun Baru",
              style: AppTheme.title.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              "Silahkan isi data diri anda",
              style: AppTheme.subtitle.copyWith(color: Colors.grey),
            ),
            const SizedBox(height: 32),
            CustomTextFormField(
              label: "Nama Lengkap",
              hintText: "Contoh: Bhasbi Alif",
              controller: _nameController,
            ),
            const SizedBox(height: 20),
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
            const SizedBox(height: 20),
            CustomTextFormField(
              label: "Konfirmasi Kata Sandi",
              isPassword: true,
              controller: _confirmPasswordController,
            ),
            const SizedBox(height: 32),
            BlocBuilder<AuthBloc, bloc.AuthState>(
              builder: (context, state) {
                return CustomButton(
                  text: "Daftar",
                  isLoading: state is bloc.AuthLoading,
                  onPressed: _onRegister,
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
