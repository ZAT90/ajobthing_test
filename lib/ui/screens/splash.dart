import 'package:ajobthing_test/bloc/splash/splash_bloc.dart';
import 'package:ajobthing_test/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../main.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
 
  @override
  Widget build(BuildContext context) {
    final splashBloc = BlocProvider.of<SplashBloc>(context);
    return BlocListener<SplashBloc, SplashState>(
      listener: (context, state) {
        // TODO: implement listener
       // logger.d('state listen: $state');
        if (state is GetInternetStatus) {
          if (!state.connected) {
          //  logger.d('not connected');
            showDialog(
                context: context,
                barrierDismissible: false,
                builder: (context) {
                  return AlertDialog(
                    title: const Text('Alert...!!!'),
                    content: const Text('Sorry. No Internet Connection'),
                    actions: [
                      TextButton(
                        child: const Text('Try again'),
                        onPressed: () {
                          splashBloc
                              .add(CheckInternetConnection(isRetry: true));
                        },
                      ),
                    ],
                  );
                });
          } else {
            // logger.d('internet connected');
            if (state.isRetry) {
              Navigator.pop(context);
            }
            Future.delayed(const Duration(seconds: 2)).then((value) =>
                Navigator.pushNamedAndRemoveUntil(context,
                    Constants.contentList, (Route<dynamic> route) => false));
          }
        }
      },
      child: BlocBuilder<SplashBloc, SplashState>(
        builder: (context, state) {
          return Scaffold(
            body: Container(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                alignment: Alignment.center,
                child: Image.asset('assets/images/splash.png')),
          );
        },
      ),
    );
  }
}

class NavString {
  bool? isSignIn;
  NavString({this.isSignIn});
}
