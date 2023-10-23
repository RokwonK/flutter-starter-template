import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_starter_template/config/di_config.dart';
import 'package:flutter_starter_template/config/firebase_config.dart';
import 'package:flutter_starter_template/config/retrofit_config.dart';

import 'package:flutter_starter_template/presentation/page/app/view/app_page.dart';

void main() {
  runZonedGuarded<Future<void>>(
      () async {
        setupFirebaseConfig();
        setupRetrofitConfig();
        setupDIConfig();
      },
      (error, stack) => {} // FirebaseCrashlytics.instance.recordError(error, stack, fatal: true)
  );

  runApp(const App());
}
