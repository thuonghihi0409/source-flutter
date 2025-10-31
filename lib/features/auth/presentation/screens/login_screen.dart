import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/di/service_locator.dart';
import '../../../../core/style/app_colors.dart';
import '../../../../core/style/app_text_styles.dart';
import '../../../../l10n/app_localizations.dart';
import '../../../../widgets/common_app_bar.dart';
import '../../../../widgets/common_button.dart';
import '../../../../widgets/common_text_field.dart';
import '../bloc/auth_bloc.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<AuthBloc>(
      create: (_) => AuthBloc(loginUseCase: sl()),
      child: const _LoginBody(),
    );
  }
}

class _LoginBody extends StatefulWidget {
  const _LoginBody();

  @override
  State<_LoginBody> createState() => _LoginBodyState();
}

class _LoginBodyState extends State<_LoginBody> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonAppBar(
        title: AppLocalizations.of(context)!.loginTitle,
        showLanguageSwitcher: true,
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(20.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(height: 24.h),
              Text(
                AppLocalizations.of(context)!.welcomeBack,
                style: AppTextStyles.headlineSmall.copyWith(
                  color: AppColors.onBackground,
                ),
              ),
              SizedBox(height: 16.h),
              CommonTextField(
                label: AppLocalizations.of(context)!.email,
                hintText: AppLocalizations.of(context)!.emailLabel,
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.emailAddress,
                controller: _emailController,
                validator: (v) => (v == null || v.isEmpty)
                    ? AppLocalizations.of(context)!.emailRequired
                    : null,
              ),
              SizedBox(height: 12.h),
              CommonTextField(
                label: AppLocalizations.of(context)!.passwordField,
                hintText: AppLocalizations.of(context)!.passwordHint,
                obscureText: true,
                controller: _passwordController,
                validator: (v) => (v == null || v.isEmpty)
                    ? AppLocalizations.of(context)!.passwordRequired
                    : null,
              ),
              SizedBox(height: 20.h),
              BlocConsumer<AuthBloc, AuthState>(
                listener: (context, state) {
                  if (state.error != null) {
                    ScaffoldMessenger.of(
                      context,
                    ).showSnackBar(SnackBar(content: Text(state.error!)));
                  }
                  if (state.isSuccess) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Đăng nhập thành công')),
                    );
                  }
                },
                builder: (context, state) {
                  return CommonButton(
                    text: AppLocalizations.of(context)!.loginButton,
                    isLoading: state.isLoading,
                    onPressed: () {
                      context.read<AuthBloc>().add(
                        LoginSubmitted(
                          email: _emailController.text.trim(),
                          password: _passwordController.text,
                        ),
                      );
                    },
                    isDisabled: state.isLoading,
                  );
                },
              ),
              const Spacer(),
              Center(
                child: Text(
                  AppLocalizations.of(context)!.selectLanguageTitle,
                  style: AppTextStyles.bodySmall.copyWith(
                    color: AppColors.gray500,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
