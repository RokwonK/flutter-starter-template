

import 'package:app_settings/app_settings.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_starter_template/domain/service/deep_linking_service.dart';
import 'package:flutter_starter_template/global/manager/logger.dart';

import 'package:permission_handler/permission_handler.dart';

class NotificationService {
  NotificationService({required this.deepLinkingService});

  final DeepLinkingService deepLinkingService;

  static const String androidChannelId = 'high_importance_channel';
  static const String androidChannelName = 'Receive Push Notification In Foreground';

  late final FlutterLocalNotificationsPlugin _localNotifications;
  late final AndroidNotificationChannel _androidChannel;
  late final InitializationSettings _initializationSettings;

  late final void Function(NotificationResponse) _foregroundLocalNotificationHandler;
  late final void Function(NotificationResponse) _backgroundLocalNotificationHandler;

  // 권한 요청
  Future<void> requestPermissionIfNotDetermined() async {
    if (await Permission.notification.isDenied) {
      await Permission.notification.request();
    }

    _setLocalNotificationHandler();
  }

  // 푸사알림이 꺼져 있는지 확인
  Future<void> get isPermanentlyDenied async => await Permission.notification.isPermanentlyDenied;

  // FCMToken 업데이트 하기
  Future<void> updateFCMToken() async {
    String? fcmToken = await FirebaseMessaging.instance.getToken();
    logger.i('$fcmToken');
    // 네트워크 통신
  }

  // 푸시알림 변경
  void switchPushAlarm(bool isOn) async {
    if (await Permission.notification.isPermanentlyDenied && isOn) {
      // 설정에서 꺼져 있는 상태라면 설정으로 이동
      AppSettings.openAppSettings(type: AppSettingsType.notification);
    } else if (isOn) {

    } else {

    }
  }

  void moveToNotificationSettings() {
    AppSettings.openAppSettings(type: AppSettingsType.notification);
  }

  // Local Notification 즉시 전송
  Future<void> immediatelySendLocalNotification({
    required LocalNotificationType type,
    required Map<String, dynamic> data
  }) async {
    // 푸시알림 Deny 상태일경우 처리
    NotificationDetails details = const NotificationDetails(
      android: AndroidNotificationDetails(androidChannelId, androidChannelName),
      iOS: DarwinNotificationDetails(
        presentAlert: true,
        presentBadge: false,
        presentSound: true,
      ),
    );

    await _localNotifications.show(
        type.id,
        type.title,
        type.description,
        details,
        payload: data.toString()
    );
  }

  // Local Notification 스케줄 추가 - 즉시 알림, 시간 전송 가능
  Future<void> addLocalNotificationSchedule() async {
    // 푸시알림 Deny 상태일경우 처리
  }

  // 등록된 Local Notification 삭제 - 스케줄 추가 시 설정한 id로 취소
  void removeScheduledLocalNotification(int id) {

  }

  // 등록된 모든 스케줄 제거
  void removeAllScheduledLocalNotification() {

  }

  // Local Notification 사용을 위한 설정등록
  Future<void> localNotificationConfig({
    required Function(NotificationResponse) foregroundHandler,
    required Function(NotificationResponse) backgroundHandler,
  }) async {
    // Android 채널 설정
    _androidChannel = const AndroidNotificationChannel(
      androidChannelId,
      androidChannelName,
      importance: Importance.max,
    );

    // Android 설정
    var initialzationSettingsAndroid = const AndroidInitializationSettings('@mipmap/ic_launcher');
    // iOS 설정
    var initialzationSettingsIOS = const DarwinInitializationSettings(
      requestSoundPermission: true,
      requestBadgePermission: true,
      requestAlertPermission: true,
    );

    // 설정 완료
    _localNotifications = FlutterLocalNotificationsPlugin();
    await _localNotifications
        .resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(_androidChannel);
    InitializationSettings initializationSettings = InitializationSettings(
        android: initialzationSettingsAndroid,
        iOS: initialzationSettingsIOS
    );
    _initializationSettings = initializationSettings;
    _foregroundLocalNotificationHandler = foregroundHandler;
    _backgroundLocalNotificationHandler = backgroundHandler;
  }

  // Local Push Handler 지정 - permission 요청이 자동으로 뜨기 때문에 Permission 요청 후에 호출
  Future<void> _setLocalNotificationHandler() async {
    await _localNotifications.initialize(
      _initializationSettings,
      onDidReceiveNotificationResponse: _foregroundLocalNotificationHandler,
      onDidReceiveBackgroundNotificationResponse: _backgroundLocalNotificationHandler,
    );
  }
}

enum LocalNotificationType {
  post(0, '새로운 게시글', '새로운 게시글을 확인해 볼까요?'),
  repost(1, '새로운 답글', '새로운 답글이 달렸습니다.');

  const LocalNotificationType(this.id, this.title, this.description);

  final int id;
  final String title;
  final String description;
}