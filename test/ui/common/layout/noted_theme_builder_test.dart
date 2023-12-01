import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:noted_app/repository/auth/local_auth_repository.dart';
import 'package:noted_app/repository/settings/local_settings_repository.dart';
import 'package:noted_app/state/settings/settings_bloc.dart';
import 'package:noted_app/state/settings/settings_event.dart';
import 'package:noted_app/ui/common/noted_library.dart';
import 'package:noted_models/noted_models.dart';

import '../../../helpers/environment/unit_test_environment.dart';
import '../../../helpers/mocks/mock_callbacks.dart';
import '../../../helpers/test_wrapper.dart';

void main() {
  group('Noted Theme Builder', () {
    const UserModel test = UserModel(id: 'test');

    setUpAll(() async {
      UnitTestEnvironment().configure(
        authRepository: LocalAuthRepository(user: test, msDelay: 1),
        settingsRepository: LocalSettingsRepository(msDelay: 1),
      );
    });

    testWidgets('theme builder rebuilds on theme update', (tester) async {
      SettingsBloc bloc = SettingsBloc();

      MockCallback<ThemeData> themeCallback = MockCallback<ThemeData>();

      await tester.pumpWidget(
        TestWrapper(
          child: BlocProvider(
            create: (BuildContext context) => bloc,
            child: NotedThemeBuilder(
              builder: (context, theme) {
                themeCallback(theme);
                return const NotedLoadingIndicator();
              },
            ),
          ),
        ),
      );

      bloc.add(const SettingsUpdateStyleColorSchemeEvent(ColorSchemeModelName.green));
      await tester.pump(const Duration(milliseconds: 10));

      verify(() => themeCallback(any())).called(2);
    });
  });
}
