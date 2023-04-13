import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pinput/pinput.dart';
import 'package:test_task/core/common/theme_provider.dart';
import 'package:test_task/core/navigation/app_router.dart';
import 'package:test_task/feature/presentation/cubits/auth_cubit/auth_cubit.dart';
import 'package:test_task/feature/presentation/cubits/auth_cubit/auth_cubit_states.dart';

@RoutePage()
class ConfirmSMSPage extends ConsumerWidget {
  final String phoneNumber;
  final TextEditingController controller;
  const ConfirmSMSPage(
      {super.key, required this.phoneNumber, required this.controller});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = ref.watch(themeModeProvider);
    final cubit = context.watch<AuthCubit>();
    return Scaffold(
      appBar: AppBar(
          backgroundColor: const Color.fromARGB(0, 0, 0, 0),
          elevation: 0,
          leading: Consumer(builder: (context, ref, child) {
            return IconButton(
                onPressed: () {
                  ref.read(themeModeProvider.notifier).state =
                      theme == ThemeMode.light
                          ? ThemeMode.dark
                          : ThemeMode.light;
                },
                icon: Icon(theme == ThemeMode.dark
                    ? Icons.light_mode_outlined
                    : Icons.dark_mode_outlined));
          })),
      backgroundColor: theme == ThemeMode.dark
          ? Theme.of(context).primaryColorDark
          : Theme.of(context).primaryColorLight,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "Верификация",
            style: TextStyle(
                fontFamily: "Lexend",
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Theme.of(context).colorScheme.onBackground),
          ),
          const SizedBox(
            height: 20,
          ),
          Text(
            "Введите код, отправленный на номер",
            style: TextStyle(
                fontFamily: "Lexend",
                fontSize: 16,
                color: Theme.of(context).colorScheme.onBackground),
          ),
          const SizedBox(
            height: 10,
          ),
          Text(
            phoneNumber,
            style: TextStyle(
                fontFamily: "Lexend",
                fontSize: 16,
                color: Theme.of(context).colorScheme.onBackground),
          ),
          const SizedBox(
            height: 35,
          ),
          Center(
            child: Pinput(
              forceErrorState: cubit.state is AuthenticationErrorState,
              controller: controller,
              androidSmsAutofillMethod: AndroidSmsAutofillMethod.none,
              length: 6,
              onCompleted: (value) async {
                await cubit.verifySMSCode(value).then((value) {
                  if (cubit.state is AuthenticatedState) {
                    AutoRouter.of(context).replaceAll([
                      const MainRouter(children: [MainRoute()])
                    ]);
                  }
                });
              },
            ),
          ),
          const SizedBox(
            height: 15,
          ),
          TextButton(
              onPressed: () {},
              child: Text("Получить новый код",
                  style: TextStyle(
                      decoration: TextDecoration.underline,
                      decorationThickness: 2,
                      fontFamily: "Lexend",
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).colorScheme.onBackground)))
        ],
      ),
    );
  }
}
