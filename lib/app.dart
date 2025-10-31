import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import 'core/di/service_locator.dart';
import 'core/routing/app_router.dart';
import 'core/services/language_service.dart';
import 'core/theme/app_theme.dart';
import 'l10n/app_localizations.dart';
import 'widgets/global_dismiss_wrapper.dart';

class App extends StatelessWidget {
  const App({super.key, required this.flavor});
  final String flavor;

  @override
  Widget build(BuildContext context) {
    const theme = AppTheme();
    return ScreenUtilInit(
      designSize: const Size(375, 812), // iPhone X design size
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return ChangeNotifierProvider<LanguageService>(
          create: (context) => sl<LanguageService>(),
          child: Consumer<LanguageService>(
            builder: (context, languageService, child) {
              return MaterialApp.router(
                debugShowCheckedModeBanner: false,
                title: 'DNPay ($flavor)',
                theme: theme.dark,
                routerConfig: appRouter,
                locale: languageService.currentLocale,
                localizationsDelegates: const [
                  AppLocalizations.delegate,
                  GlobalMaterialLocalizations.delegate,
                  GlobalWidgetsLocalizations.delegate,
                  GlobalCupertinoLocalizations.delegate,
                ],
                supportedLocales: LanguageService.supportedLocales,
                builder: (context, child) {
                  return GlobalDismissWrapper(child: child!);
                },
              );
            },
          ),
        );
      },
    );
  }
}
