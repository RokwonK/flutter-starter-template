
import 'package:flutter_starter_template/data/data_source/data_source.dart';
import 'package:flutter_starter_template/data/repository/repository.dart';
import 'package:flutter_starter_template/domain/service/deep_linking_service.dart';
import 'package:flutter_starter_template/domain/service/notification_service.dart';
import 'package:flutter_starter_template/domain/service/tracking_event_service.dart';
import 'package:flutter_starter_template/global/constant.dart';
import 'package:get_it/get_it.dart';

import 'config.dart';

final getIt = GetIt.instance;

void setupDIConfig() {
  _setupData();
  _setupRepository();
  _setupService();
  _setupUseCase();
}

void _setupData() {
  getIt.registerSingleton(LocalObjectDataSource());
  getIt.registerSingleton(LocalKeyValueDataSource());
}

void _setupRepository() {
  // network
  getIt.registerLazySingleton(() => AuthRepository(baseApiDio, baseUrl: baseUrl));

  // local
}

void _setupService() {
  getIt.registerSingleton(DeepLinkingService(dataSource: getIt.get<LocalKeyValueDataSource>()));
  getIt.registerSingleton(NotificationService(deepLinkingService: getIt.get<DeepLinkingService>()));
  getIt.registerSingleton(TrackingEventService());
}

void _setupUseCase() {

}