import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_starter_template/global/enum.dart';

part 'app_event.dart';
part 'app_state.dart';

class AppBloc extends Bloc<AppEvent, AppState> {
  AppBloc() : super(const AppState(status: LoadingStatus.init)) {
    on<AppLoadingStatusChanged>(_changeLoadingStatus);
  }

  Future<void> _changeLoadingStatus(
    AppLoadingStatusChanged event,
    Emitter<AppState> emit
  ) async {
    emit(state.copyWith(status: event.status));
  }
}