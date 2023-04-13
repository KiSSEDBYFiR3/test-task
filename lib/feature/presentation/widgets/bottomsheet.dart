import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_task/core/navigation/app_router.dart';
import 'package:test_task/feature/presentation/cubits/auth_cubit/auth_cubit.dart';
import 'package:test_task/feature/presentation/widgets/widget_fields.dart';

Widget buildEmailBottomSheet({
  required BuildContext context,
  required FormKey key,
  required TextEditingController controller,
}) {
  return Material(
    color: Theme.of(context).primaryColor,
    child: Column(mainAxisSize: MainAxisSize.min, children: [
      Padding(
          padding: const EdgeInsets.only(top: 20, right: 50.0, left: 50),
          child: emailField(
              context: context, formKey: key, controller: controller)),
      Padding(
          padding: const EdgeInsets.all(8.0),
          child: SizedBox(
            width: 120,
            height: 45,
            child: ElevatedButton(
              style: const ButtonStyle(
                  shape: MaterialStatePropertyAll(RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(25)))),
                  elevation: MaterialStatePropertyAll(0.3),
                  backgroundColor: MaterialStatePropertyAll(
                      Color.fromARGB(255, 123, 8, 180))),
              onPressed: () {
                if (key.currentState!.validate()) {
                  BlocProvider.of<AuthCubit>(context)
                      .sendEmailLink(controller.text);
                  context.popRoute();
                  controller.clear();
                }
              },
              child: const Text(
                "Подтвердить",
                style: TextStyle(
                    fontFamily: "SF-Pro", fontSize: 14, color: Colors.white),
              ),
            ),
          ))
    ]),
  );
}

Widget buildSMSBottomSheet(
    {required BuildContext context,
    required FormKey key,
    required TextEditingController controller}) {
  return Material(
      color: Theme.of(context).colorScheme.surface,
      child: Column(mainAxisSize: MainAxisSize.min, children: [
        Padding(
            padding: const EdgeInsets.only(top: 20, right: 50.0, left: 50),
            child: phoneNumberField(
                context: context, formKey: key, controller: controller)),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: SizedBox(
              width: 120,
              height: 45,
              child: ElevatedButton(
                style: ButtonStyle(
                    shape: const MaterialStatePropertyAll(
                        RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(25)))),
                    elevation: const MaterialStatePropertyAll(0.3),
                    backgroundColor: MaterialStatePropertyAll(
                        Theme.of(context).colorScheme.primary)),
                onPressed: () async {
                  if (key.currentState!.validate()) {
                    context.popRoute();
                    AutoRouter.of(context).push(AuthRouter(children: [
                      ConfirmSMSRoute(
                          phoneNumber: controller.text, controller: controller)
                    ]));
                    await BlocProvider.of<AuthCubit>(context)
                        .sendSMSCode(phoneNumber: controller.text);
                    controller.clear();
                  }
                },
                child: const Text(
                  "Подтвердить",
                  style: TextStyle(
                      fontFamily: "SF-Pro", fontSize: 14, color: Colors.white),
                ),
              )),
        ),
      ]));
}
