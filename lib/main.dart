import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_starter_template/config/bloc_config.dart';
import 'package:flutter_starter_template/config/di_config.dart';
import 'package:flutter_starter_template/config/firebase_config.dart';
import 'package:flutter_starter_template/config/retrofit_config.dart';
import 'package:flutter_starter_template/global/constant.dart';
import 'package:flutter_starter_template/presentation/page/app/app.dart';

import 'package:flutter_starter_template/presentation/page/app/view/app_page.dart';

void main() {
  // 에러(충돌)가 나도 앱이 강제종료되지 않게 해주는 방어막
  runZonedGuarded<Future<void>>(
      () async {
        // Flutter가 초기화 될때까지 기다림
        WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
        // Splash 상태에서 대기
        FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

        // 설정
        await dotenv.load(fileName: 'assets/config/.env');
        setupFirebaseConfig();
        setupRetrofitConfig();
        setupDIConfig();
        setupBlocConfig();

        // 앱 실행
        runApp(const App());
        // Splash 종료
        FlutterNativeSplash.remove();
      },
      (error, stack) => {} // FirebaseCrashlytics.instance.recordError(error, stack, fatal: true)
  );
}
