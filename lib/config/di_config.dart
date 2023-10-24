
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

}

void _setupRepository() {
  getIt.registerLazySingleton(() => AuthRepository(baseApiDio, baseUrl: baseUrl));
}

void _setupUseCase() {

}