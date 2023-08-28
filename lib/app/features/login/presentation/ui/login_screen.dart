import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_template/app/features/login/presentation/bloc/login_bloc.dart';
import 'package:flutter_template/app/features/login/presentation/bloc/login_event.dart';
import 'package:flutter_template/app/features/login/presentation/bloc/login_state.dart';
import 'package:flutter_template/app/shared/components/alert/app_alert.dart';
import 'package:flutter_template/app/shared/components/alert/app_alert_style.dart';
import 'package:flutter_template/app/shared/components/button/app_button.dart';
import 'package:flutter_template/app/shared/components/textField/app_textfield.dart';
import 'package:flutter_template/app/shared/components/textField/app_textfield_style.dart';
import 'package:flutter_template/app/shared/style/app_colors.dart';
import 'package:flutter_template/app/shared/style/app_icons.dart';
import 'package:flutter_template/app/shared/style/app_images.dart';
import 'package:flutter_template/app/shared/style/app_text_style.dart';
import 'package:flutter_template/l10n/l10n.dart';

const usernameFieldKey = ValueKey('username');
const passwordFieldKey = ValueKey('password');

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return Scaffold(
      backgroundColor: AppColors.primaryMain,
      extendBodyBehindAppBar: true,
      body: SafeArea(
        child: BlocListener<LoginBloc, LoginState>(
          listenWhen: (previous, current) =>
              current.status == LoginStatus.failure ||
              current.status == LoginStatus.succeeded,
          listener: (context, state) {
            if (state.status == LoginStatus.failure) {
              AppAlert.show(
                context,
                state.failure?.message() ??
                    l10n.commonErrorUnknownFailureMessage,
                variant: AppAlertVariant.error,
              );
            } else if (state.status == LoginStatus.succeeded) {
              //context.go(RoutesPaths.home);
            }
          },
          child: BlocBuilder<LoginBloc, LoginState>(
            builder: (context, state) => Center(
              child: Container(
                constraints: const BoxConstraints(maxWidth: 800),
                child: Form(
                  child: CustomScrollView(
                    physics: const ClampingScrollPhysics(),
                    slivers: [
                      SliverFillRemaining(
                        hasScrollBody: false,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(
                              height: 60,
                            ),
                            Center(
                              child: Image.asset(
                                AppImages.company_logo,
                                height: 80,
                              ),
                            ),
                            const SizedBox(
                              height: 100,
                            ),
                            Text(
                              l10n.loginWelcomeLabel,
                              style: AppTextStyles.headingLevel2BoldWhiteSx,
                              textAlign: TextAlign.left,
                            ),
                            const SizedBox(
                              height: 4,
                            ),
                            Text(
                              l10n.loginInsertDataLabel,
                              style: AppTextStyles.body16pxRegularWhiteSx,
                            ),
                            const SizedBox(
                              height: 36,
                            ),
                            AppTextField(
                              key: usernameFieldKey,
                              placeHolder: 'username',
                              onChange: (value) => context
                                  .read<LoginBloc>()
                                  .add(UsernameChanged(newUsername: value)),
                            ),
                            const SizedBox(
                              height: 58,
                            ),
                            AppTextField(
                              key: passwordFieldKey,
                              placeHolder: 'password',
                              type: state.showPassword
                                  ? AppTextFieldType.text
                                  : AppTextFieldType.password,
                              rightIcon: state.showPassword
                                  ? AppIcons.visibilityOn
                                  : AppIcons.visibilityOff,
                              onRightIconTap: () =>
                                  _togglePasswordVisibility(context),
                              onChange: (value) => context
                                  .read<LoginBloc>()
                                  .add(PasswordChanged(newPassword: value)),
                            ),
                            const SizedBox(
                              height: 55,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                AppButton(
                                  disabled: state.status == LoginStatus.loading,
                                  text: l10n.loginLoginButton,
                                  onClick: () => _onLoginButtonPressed(context),
                                ),
                              ],
                            ),
                            const Spacer(),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _onLoginButtonPressed(BuildContext context) {
    context.read<LoginBloc>().add(
          const LoginButtonPressed(),
        );
  }

  void _togglePasswordVisibility(BuildContext context) {
    context.read<LoginBloc>().add(
          TogglePasswordIconPressed(),
        );
  }
}
