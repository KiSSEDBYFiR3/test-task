import 'package:flutter/material.dart';

showErrorSnackBar(BuildContext context, String message) {
  return ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      duration: const Duration(seconds: 2),
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(20))),
      backgroundColor: Theme.of(context).colorScheme.error,
      content: SizedBox(
        child: Center(
          child: Text(
            message,
            style: TextStyle(
                fontFamily: "Lexend",
                fontWeight: FontWeight.w500,
                fontSize: 17,
                color: Theme.of(context).colorScheme.onError),
          ),
        ),
      )));
}
