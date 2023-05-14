part of 'splash_bloc.dart';

@immutable
abstract class SplashEvent {}

class CheckInternetConnection extends SplashEvent {
  final bool isRetry;
  CheckInternetConnection({this.isRetry = false});
}

class CheckUserLoggedIn extends SplashEvent {}
