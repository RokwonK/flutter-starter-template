
import 'package:bloc/bloc.dart';
import 'package:flutter_starter_template/global/manager/logger.dart';

void setupBlocConfig() {
  // Bloc 상태감지 Observer 추가
  Bloc.observer = const _AppBlocObserver();
}

class _AppBlocObserver extends BlocObserver {
  const _AppBlocObserver();

  @override
  void onChange(BlocBase<dynamic> bloc, Change<dynamic> change) {
    super.onChange(bloc, change);
    logger.i('onChange(${bloc.runtimeType}, $change)');
  }

  @override
  void onError(BlocBase<dynamic> bloc, Object error, StackTrace stackTrace) {
    logger.e('onError(${bloc.runtimeType}, $error, $stackTrace)');
    super.onError(bloc, error, stackTrace);
  }
}