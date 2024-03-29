import 'package:flutter/material.dart';
import 'package:noted_app/state/auth/auth_bloc.dart';
import 'package:noted_app/state/auth/auth_state.dart';
import 'package:noted_app/ui/common/noted_library.dart';
import 'package:noted_app/ui/pages/login/login_loading.dart';
import 'package:noted_app/ui/router/router_config.dart';
import 'package:noted_app/util/extensions/extensions.dart';
import 'package:noted_app/ui/router/noted_router.dart';

const ValueKey _contentKey = ValueKey('content');
const ValueKey _loadingKey = ValueKey('loading');

// coverage:ignore-file
class LoginFrame extends StatelessWidget {
  final bool hasBackButton;
  final String? headerTitle;
  final String? contentTitle;
  final Widget Function(Key) contentBuilder;
  final void Function(BuildContext, AuthState)? stateListener;

  const LoginFrame({
    this.hasBackButton = true,
    this.headerTitle,
    this.contentTitle,
    required this.contentBuilder,
    this.stateListener,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    ThemeData theme = context.theme();

    return NotedHeaderPage(
      hasBackButton: hasBackButton,
      title: headerTitle,
      child: Align(
        alignment: Alignment.bottomCenter,
        child: ListView(
          physics: const ClampingScrollPhysics(),
          shrinkWrap: true,
          padding: const EdgeInsets.symmetric(horizontal: 20),
          children: [
            if (contentTitle != null)
              Text(
                contentTitle!,
                style: theme.textTheme.displayLarge,
                textAlign: TextAlign.center,
              ),
            const SizedBox(height: 36),
            ConstrainedBox(
              constraints: BoxConstraints.loose(const Size.fromWidth(400)),
              child: NotedSvg.asset(
                source: 'assets/svg/woman_reading.svg',
                color: theme.colorScheme.tertiary,
                fit: BoxFit.fitWidth,
              ),
            ),
            SizedBox(
              height: 330,
              child: NotedBlocSelector<AuthBloc, AuthState, AuthStatus>(
                selector: (state) => state.status,
                listener: stateListener,
                selectedListener: (context, state) {
                  if (state == AuthStatus.authenticated) {
                    context.replace(HomeRoute());
                  }
                },
                builder: (context, _, state) => switch (state) {
                  AuthStatus.unauthenticated => contentBuilder(_contentKey),
                  _ => LoginLoading(status: state, key: _loadingKey),
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
