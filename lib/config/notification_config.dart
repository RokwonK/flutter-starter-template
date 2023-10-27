
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_starter_template/config/config.dart';
import 'package:flutter_starter_template/domain/service/deep_linking_service.dart';
import 'package:flutter_starter_template/domain/service/notification_service.dart';
import 'package:flutter_starter_template/global/manager/logger.dart';

// Firebase 우선설정 필수
Future<void> setupNotificationConfig(NotificationService notificationService, DeepLinkingService deepLinkingService) async {
  await _setupRemoteNotificationHandler(deepLinkingService);
  await notificationService.localNotificationConfig(
      foregroundHandler: localNotificationHandlerFromForeground,
      backgroundHandler: localNotificationHandlerFromBackground
  );
}

Future<void> _setupRemoteNotificationHandler(DeepLinkingService deepLinkingService) async {
  // Terminated 상태, Background, Foreground 에서 푸시 클릭
  final receivedMessage = await FirebaseMessaging.instance.getInitialMessage();
  remoteNotificationHandlerFromBackground(receivedMessage);
  FirebaseMessaging.onMessageOpenedApp.listen(remoteNotificationHandlerFromBackground);
  FirebaseMessaging.onMessage.listen(remoteNotificationHandlerFromForeground);
}

/*
  모든 Notification Handler는 Entry Point(main)에서 접근가능하도록 전역으로 만들어야함
*/
Future<void> remoteNotificationHandlerFromBackground(RemoteMessage? message) async {
  if (message != null && message.notification != null) {
    getIt.get<DeepLinkingService>().saveDeepLink(remoteData: message.data);
    logger.i('Remote Notification - Background : SUCCESS');
  } else {
    logger.e('Notification Error : 데이터가 들어 있지 않음');
  }
}

Future<void> remoteNotificationHandlerFromForeground(RemoteMessage? message) async {
  if (message != null && message.notification != null) {
    getIt.get<DeepLinkingService>().saveDeepLink(remoteData: message.data);
    logger.i('Remote Notification - Foreground : SUCCESS');
  } else {
    logger.e('Notification Error : 데이터가 들어 있지 않음');
  }
}

Future<void> localNotificationHandlerFromForeground(NotificationResponse response) async {
  if (response.payload != null) {
    getIt.get<DeepLinkingService>().saveDeepLink(localData: response.payload);
    logger.i('Local Notification - Foreground : SUCCESS');
  }
}

Future<void> localNotificationHandlerFromBackground(NotificationResponse response) async {
  if (response.payload != null) {
    getIt.get<DeepLinkingService>().saveDeepLink(localData: response.payload);
    logger.i('Local Notification - Foreground : SUCCESS');
  }
}