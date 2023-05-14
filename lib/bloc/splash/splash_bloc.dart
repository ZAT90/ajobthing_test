import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

part 'splash_event.dart';
part 'splash_state.dart';

class SplashBloc extends Bloc<SplashEvent, SplashState> {
  SplashBloc() : super(SplashInitial()) {
    on<CheckInternetConnection>(
      (event, emit) async => await checkIfConnectedInternet(event, emit),
    );
  }

  Future<void> checkIfConnectedInternet(
      CheckInternetConnection event, Emitter emit) async {
    print('check if internet connected');
    final connectivityResult = await (Connectivity().checkConnectivity());
    // ignore: invalid_use_of_visible_for_testing_member
    emit(GetInternetStatus(
        connected: connectivityResult == ConnectivityResult.mobile ||
            connectivityResult == ConnectivityResult.wifi,
        isRetry: event.isRetry));
  }

}
