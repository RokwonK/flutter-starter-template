part of 'app_bloc.dart';


class AppState extends Equatable {
  const AppState({
    required this.status
  });

  final LoadingStatus status;

  AppState copyWith({
    LoadingStatus? status
  }) => AppState(status: status ?? this.status);

  @override
  List<Object> get props => [status];
}
