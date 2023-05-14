part of 'splash_bloc.dart';

@immutable
abstract class SplashState {}

class SplashInitial extends SplashState {}

class GetInternetStatus extends SplashState {
  final bool connected;
  final bool isRetry;
  GetInternetStatus({required this.connected, required this.isRetry});
}

class GetUserLoggedIn extends SplashState {
  final bool isUserLoggedIn;
  GetUserLoggedIn({required this.isUserLoggedIn});
}
