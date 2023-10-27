
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart';

// import 'firebase_options.dart';

// Notification 설정 제외
Future<void> setupFirebaseConfig() async {
  // 공통설정
  // await Firebase.initializeApp(
  //   options: DefaultFirebaseOptions.currentPlatform,
  // );

  await _setupCloudMessaging();
  await _setupCrashlyticsConfig();
  _setupEventConfig();
}

// Firebase Cloud Message 설정
Future<void> _setupCloudMessaging() async {
  // iOS 앱이 포그라운드 상태에서도 알림 받을 수 있도록 설정
  await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
    alert: true,
    badge: false,
    sound: true,
  );
}

// Firebase Crashlytics 설정
Future<void> _setupCrashlyticsConfig() async {
  // Flutter 프레임워크 내에서 발생하는 모든 오류를 자동으로 포착
  FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterFatalError;

  // 비동기(async 함수에서 발생) 함수에서 발생하는 오류 포착
  PlatformDispatcher.instance.onError = (error, stack) {
    FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
    return true;
  };

  // 사용자 지정 보고 - 심각하지 않은 오류보고 catch해서 받은 것 넘기기 (최근 8개까지만 Crashlytics가 저장함)
  /*
    await FirebaseCrashlytics.instance.recordError(
      exception,
      stackTrace,
      reason: 'a non-fatal error',
      information: ['description 1', 'description 2']
    );
  */
}

// Firebase Event 설정
void _setupEventConfig() {
  // 로그 이벤트
  // SkAdNetwork 관련 에러발생 - 아마 Xcode 버전 문제일 확률 높음
  /*
    await FirebaseAnalytics.instance.logEvent(
      name: "select_content",
      parameters: {
        "content_type": "image",
        "item_id": itemId,
      },
    );
  */
}