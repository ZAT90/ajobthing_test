import 'package:flutter/material.dart';

class ErrorDialog extends StatelessWidget {
  final String errorMessage;
  final Function() onRetry;
  const ErrorDialog(
      {Key? key, required this.errorMessage, required this.onRetry})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        elevation: 0.0,
        backgroundColor: Colors.white,
        child: Wrap(
          children: [
            Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.all(30),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    errorMessage,
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  ElevatedButton(
                      onPressed: () => onRetry(), child: const Text('Retry'))
                ],
              ),
            ),
          ],
        ));
  }
}
