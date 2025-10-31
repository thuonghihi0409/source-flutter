import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_app/app.dart';
import 'package:flutter_app/core/di/service_locator.dart';

Future<void> main() async {
  runZonedGuarded(() async {
    WidgetsFlutterBinding.ensureInitialized();
    const flavor = String.fromEnvironment('FLAVOR', defaultValue: 'dev');
    await configureDependencies();
    runApp(const App(flavor: flavor));
  }, (e, s) => debugPrint('Uncaught: $e\n$s'));
}
