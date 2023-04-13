import 'package:flutter/material.dart';
import 'package:regexed_validator/regexed_validator.dart';

typedef FormKey = GlobalKey<FormFieldState>;

Widget emailField(
    {required BuildContext context,
    required FormKey formKey,
    required TextEditingController controller}) {
  return TextFormField(
      key: formKey,
      textInputAction: TextInputAction.next,
      autocorrect: false,
      validator: (value) {
        if (!validator.email(value ?? "")) {
          return 'Введите правильный адрес!';
        }
        return null;
      },
      controller: controller,
      style: TextStyle(color: Theme.of(context).colorScheme.onBackground),
      cursorColor: Theme.of(context).colorScheme.onPrimary,
      decoration: InputDecoration(
        filled: true,
        labelStyle: TextStyle(color: Theme.of(context).colorScheme.onPrimary),
        focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Color.fromARGB(255, 179, 179, 179)),
            borderRadius: BorderRadius.all(Radius.circular(25))),
        contentPadding: const EdgeInsets.fromLTRB(12, 24, 12, 16),
        hintText: "Введите адрес почты",
        hintStyle: TextStyle(
            fontFamily: 'Lexend',
            color: Theme.of(context).colorScheme.onPrimary),
        border: OutlineInputBorder(
          borderRadius: const BorderRadius.all(Radius.circular(25)),
          borderSide: BorderSide(color: Theme.of(context).colorScheme.primary),
        ),
      ));
}

Widget phoneNumberField(
    {required BuildContext context,
    required FormKey formKey,
    required TextEditingController controller}) {
  return TextFormField(
      key: formKey,
      textInputAction: TextInputAction.next,
      autocorrect: false,
      validator: (value) {
        if (!validator.phone(value ?? "")) {
          return 'Введите правильный номер телефона!';
        }
        return null;
      },
      controller: controller,
      style: TextStyle(color: Theme.of(context).colorScheme.onBackground),
      cursorColor: Theme.of(context).colorScheme.onPrimary,
      decoration: InputDecoration(
        filled: true,
        labelStyle: TextStyle(color: Theme.of(context).colorScheme.onPrimary),
        focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Color.fromARGB(255, 179, 179, 179)),
            borderRadius: BorderRadius.all(Radius.circular(25))),
        contentPadding: const EdgeInsets.fromLTRB(12, 24, 12, 16),
        hintText: "Введите номер телефона",
        hintStyle: TextStyle(
            fontFamily: 'Lexend',
            color: Theme.of(context).colorScheme.onPrimary),
        border: OutlineInputBorder(
          borderRadius: const BorderRadius.all(Radius.circular(25)),
          borderSide: BorderSide(color: Theme.of(context).colorScheme.primary),
        ),
      ));
}
