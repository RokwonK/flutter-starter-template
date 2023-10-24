
import 'package:flutter_starter_template/data/data_source/data_source.dart';
import 'package:flutter_starter_template/data/repository/repository.dart';
import 'package:flutter_starter_template/global/constant.dart';
import 'package:get_it/get_it.dart';

import 'config.dart';

final getIt = GetIt.instance;

void setupDIConfig() {
  // 의존성 호출 시 => getIt.get<AuthRepository>();
  _setupData();
  _setupRepository();
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

void _setupUseCase() {

}