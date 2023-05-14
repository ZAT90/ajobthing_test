import 'package:flutter/material.dart';

Row loaderWidget() {
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: const [
      CircularProgressIndicator(
        backgroundColor: Colors.blue,
        // value: 20,
        strokeWidth: 8,
      ),
      SizedBox(
        width: 15,
      ),
      Text('loading...'),
    ],
  );
}
