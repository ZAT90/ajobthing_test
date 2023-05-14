import 'package:ajobthing_test/bloc/content/content_bloc.dart';
import 'package:ajobthing_test/bloc/splash/splash_bloc.dart';
import 'package:ajobthing_test/main.dart';
import 'package:ajobthing_test/model/blog.dart';
import 'package:ajobthing_test/model/candidate.dart';
import 'package:ajobthing_test/ui/screens/blog/blogDetail.dart';
import 'package:ajobthing_test/ui/screens/candidate/candidateDetail.dart';
import 'package:ajobthing_test/ui/screens/contentList.dart';
import 'package:ajobthing_test/ui/screens/splash.dart';
import 'package:ajobthing_test/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RouterNavigator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    final arguments = settings.arguments;
    // logger.d('arguments named route: $arguments');
    switch (settings.name) {
      case Constants.splashScreen:
        return MaterialPageRoute<SplashScreen>(
            builder: (context) => BlocProvider(
                  create: (context) =>
                      SplashBloc()..add(CheckInternetConnection()),
                  child: const SplashScreen(),
                ));
      case Constants.contentList:
        return MaterialPageRoute<ContentList>(
            builder: (context) => BlocProvider(
                  create: (context) => ContentBloc()..add(LoadContentList()),
                  child: const ContentList(),
                ));
      case Constants.candidateDetails:
        return MaterialPageRoute<CandidateDetail>(
            builder: (context) => BlocProvider(
                  create: (context) => ContentBloc()
                    ..add(LoadCandidateDetails(
                        candidateResult: arguments as CandidateResult)),
                  child: const CandidateDetail(),
                ));
      case Constants.blogDetails:
        return MaterialPageRoute<BlogDetail>(
            builder: (context) => BlogDetail(
                  blogResult: arguments as BlogResult,
                ));
      // case chatPageRoute:
      //   return MaterialPageRoute<ChatApp>(builder: (context) => ChatApp());

      default:
        return MaterialPageRoute<SplashScreen>(
            builder: (context) => BlocProvider(
                  create: (context) =>
                      SplashBloc()..add(CheckInternetConnection()),
                  child: const SplashScreen(),
                ));
    }
  }
}
