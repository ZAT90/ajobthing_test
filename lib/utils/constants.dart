import 'package:flutter/material.dart';
import 'package:logger/logger.dart';

class Constants {
  BuildContext context;
  Constants(this.context);
  // screen height and width
  double get width => MediaQuery.of(context).size.width;
  double get height => MediaQuery.of(context).size.height;

  // route constants
  static const String splashScreen = '/';
  static const String contentList = '/contentList';
  static const String candidateDetails = '/candidateDetails';
  static const String blogDetails = '/blogDetails';
  //static const String home = '/home';

  static InputDecoration textFieldWithoutIcons({
    String hintTextStr = "",
    Widget? prefix,
  }) {
    return InputDecoration(
      fillColor: Colors.white,
      isDense: true,
      filled: true,
      labelText: hintTextStr,
      labelStyle: const TextStyle(color: Colors.black54),
      contentPadding: const EdgeInsets.fromLTRB(15, 0, 15, 30),
      // hintStyle: const TextStyle(color: Colors.black54 ),
      floatingLabelBehavior: FloatingLabelBehavior.never,
      errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(13.0),
          borderSide: const BorderSide(color: Colors.red)),
      focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(13.0),
          borderSide: const BorderSide(color: Colors.black)),
      enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(13.0),
          borderSide: const BorderSide(color: Colors.grey)),
      // border:
    );
  }

  // static InputDecoration textFieldWithSuffixIcons(
  //     {String hintTextStr = "",
  //     Widget? prefix,
  //     bool isFilled = false,
  //    }) {
  //   return InputDecoration(
  //     fillColor: Colors.black,
  //     isDense: true,
  //     filled: true,
  //     prefixIcon: prefix,
  //     suffixIcon: IconButton(
  //       padding: EdgeInsets.zero,
  //       icon: Image.asset(
  //         'assets/images/arrowDownBlack.png',
  //         height: 15,
  //       ),
  //       onPressed: () {},
  //     ),
  //     // suffixIconConstraints: BoxConstraints(
  //     //                 minHeight: 13,
  //     //                 minWidth: 13
  //     //               ),
  //     // suffixIcon: Image(
  //     //     image: AssetImage('assets/images/arrowDownBlack.png'),
  //     //     height: 1,
  //     //     width: 1,
  //     //   ),

  //     contentPadding: EdgeInsets.fromLTRB(15, 0, 15, 30),
  //     hintStyle: TextStyle(color: isFilled ? Colors.black54 : Colors.grey),
  //     labelText: hintTextStr,
  //     floatingLabelBehavior: FloatingLabelBehavior.never,
  //     errorBorder: OutlineInputBorder(
  //         borderRadius: BorderRadius.circular(13.0),
  //         borderSide: BorderSide(color: Colors.red)),
  //     focusedBorder: OutlineInputBorder(
  //         borderRadius: BorderRadius.circular(13.0),
  //         borderSide: BorderSide(
  //             color: Colors.grey)),
  //     enabledBorder: OutlineInputBorder(
  //         borderRadius: BorderRadius.circular(13.0),
  //         borderSide: BorderSide(color: Colors.transparent)),
  //     // border:
  //   );
  // }
}
