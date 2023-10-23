part of 'app_bloc.dart';

abstract class AppEvent extends Equatable {
  const AppEvent();

  @override
  List<Object?> get props => [];
}

class AppLoadingStatusChanged extends AppEvent {
  const AppLoadingStatusChanged({ required this.status });

  final LoadingStatus status;
}