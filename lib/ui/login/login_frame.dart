import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:noted_app/state/auth/auth_bloc.dart';
import 'package:noted_app/state/auth/auth_state.dart';
import 'package:noted_app/ui/common/noted_library.dart';
import 'package:noted_app/ui/login/login_loading.dart';
import 'package:noted_app/util/extensions.dart';
import 'package:noted_app/util/routing/noted_router.dart';

const ValueKey _contentKey = const ValueKey('content');
const ValueKey _loadingKey = const ValueKey('loading');

class LoginFrame extends StatelessWidget {
  final bool hasBackButton;
  final String? headerTitle;
  final String? contentTitle;
  final Widget Function(Key) contentBuilder;

  const LoginFrame({
    this.hasBackButton = true,
    this.headerTitle,
    this.contentTitle,
    required this.contentBuilder,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    ThemeData theme = context.theme();
    ColorFilter filter = ColorFilter.mode(theme.colorScheme.tertiary, BlendMode.srcIn);

    return NotedHeaderPage(
      hasBackButton: hasBackButton,
      title: headerTitle,
      child: Align(
        alignment: Alignment.bottomCenter,
        child: ListView(
          physics: ClampingScrollPhysics(),
          shrinkWrap: true,
          padding: EdgeInsets.symmetric(horizontal: 20),
          children: [
            if (contentTitle != null)
              Text(
                contentTitle!,
                style: theme.textTheme.displayLarge,
                textAlign: TextAlign.center,
              ),
            SizedBox(height: 36),
            ConstrainedBox(
              constraints: BoxConstraints.loose(Size.fromWidth(400)),
              child: SvgPicture.asset(
                'assets/svg/woman_reading.svg',
                colorFilter: filter,
                fit: BoxFit.fitWidth,
              ),
            ),
            SizedBox(
              height: 330,
              child: BlocConsumer<AuthBloc, AuthState>(
                listener: (context, state) {
                  if (state.status == AuthStatus.authenticated) {
                    context.replace('/');
                  }
                },
                builder: (context, state) => AnimatedSwitcher(
                  duration: const Duration(milliseconds: 200),
                  switchInCurve: Curves.easeIn,
                  switchOutCurve: Curves.easeOut,
                  transitionBuilder: (Widget child, Animation<double> animation) => SlideTransition(
                    position: Tween(
                      begin: child.key == _contentKey ? Offset(-1.0, 0.0) : Offset(1.0, 0.0),
                      end: Offset(0.0, 0.0),
                    ).animate(animation),
                    child: child,
                  ),
                  child: switch (state.status) {
                    AuthStatus.unauthenticated => contentBuilder(_contentKey),
                    _ => LoginLoading(status: state.status, key: _loadingKey),
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
