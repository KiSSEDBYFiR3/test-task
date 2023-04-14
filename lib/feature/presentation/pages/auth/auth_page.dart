import 'package:auto_route/auto_route.dart';
import 'package:checkmark/checkmark.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:scaffold_gradient_background/scaffold_gradient_background.dart';
import 'package:test_task/core/common/checkmark_provider.dart';
import 'package:test_task/core/common/theme_provider.dart';
import 'package:test_task/core/di/di.dart';
import 'package:test_task/core/navigation/app_router.dart';
import 'package:test_task/feature/presentation/cubits/auth_cubit/auth_cubit.dart';
import 'package:test_task/feature/presentation/cubits/auth_cubit/auth_cubit_states.dart';
import 'package:test_task/feature/presentation/widgets/bottomsheet.dart';
import 'package:test_task/feature/presentation/widgets/snackbar.dart';
import 'package:test_task/feature/presentation/widgets/widget_fields.dart';

@RoutePage()
class AuthPage extends StatefulWidget {
  AuthPage({
    super.key,
  });

  @override
  State<AuthPage> createState() => _AuthPageState();

  final auth = diContainer.createAuthCubit();
}

class _AuthPageState extends State<AuthPage> with WidgetsBindingObserver {
  final GlobalKey<FormFieldState> _formKey = GlobalKey<FormFieldState>();
  late final TextEditingController _emailController;
  late final TextEditingController _smsController;

  @override
  void initState() {
    super.initState();
    _emailController = TextEditingController();
    _smsController = TextEditingController();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) async {
    super.didChangeAppLifecycleState(state);
    final cubit = BlocProvider.of<AuthCubit>(context);
    await cubit.authenticateByDynamicLinkCredential();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _smsController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ScaffoldGradientBackground(
      resizeToAvoidBottomInset: false,
      gradient: LinearGradient(colors: [
        Theme.of(context).colorScheme.primary,
        Theme.of(context).colorScheme.background,
      ], begin: Alignment.bottomRight, end: Alignment.topLeft),
      appBar: AppBar(
          backgroundColor: const Color.fromARGB(0, 0, 0, 0),
          elevation: 0,
          title: Consumer(builder: (context, ref, child) {
            final theme = ref.watch(themeModeProvider);
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
      body: BlocBuilder<AuthCubit, AuthCubitState>(
        builder: (context, state) {
          /// Инициализирую состояния
          if (state is InitState) {
            return GestureDetector(
              onTap: () =>
                  SystemChannels.textInput.invokeMethod('TextInput.hide'),
              child: SafeArea(
                  child: SingleChildScrollView(
                      child: Center(
                child: Padding(
                  padding: const EdgeInsets.only(top: 30),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(30.0),
                        child: _logo(),
                      ),
                      _authWithEmail(
                        context: context,
                        formKey: _formKey,
                        controller: _emailController,
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      _authWithSMS(
                          context: context,
                          formKey: _formKey,
                          controller: _smsController),
                      const SizedBox(
                        height: 15,
                      ),
                      _authWithBiometrics(context),
                    ],
                  ),
                ),
              ))),
            );
          }
          if (state is AuthenticatedState) {
            return Consumer(builder: (context, ref, child) {
              final isActive = ref.watch(checkMarkProvider);
              Future.delayed(const Duration(milliseconds: 200)).whenComplete(
                  () => ref.read(checkMarkProvider.notifier).state = true);
              return Center(
                  child: SizedBox(
                      height: 70,
                      width: 70,
                      child: CheckMark(
                          inactiveColor: Theme.of(context).primaryColorDark,
                          active: isActive,
                          duration: const Duration(milliseconds: 700),
                          onEnd: () =>
                              Future.delayed(const Duration(milliseconds: 200))
                                  .whenComplete(() {
                                AutoRouter.of(context).replaceAll([
                                  const MainRouter(children: [MainRoute()])
                                ]);
                              }))));
            });
          }

          if (state is AuthenticationErrorState) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              showErrorSnackBar(context, state.message.toString());
            });
          }
          return Center(
            child: SizedBox(
              height: 50,
              width: 50,
              child: CircularProgressIndicator(
                  color: Theme.of(context).primaryColorDark),
            ),
          );
        },
      ),
    );
  }

  Widget _logo() {
    return Container(
      height: 150,
      width: 150,
      decoration: const BoxDecoration(
          image: DecorationImage(
        image: AssetImage("assets/auth/e-commerce-logo.png"),
        filterQuality: FilterQuality.high,
      )),
    );
  }
}

Widget _authWithSMS(
    {required BuildContext context,
    required FormKey formKey,
    required TextEditingController controller}) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 20.0),
    child: SizedBox(
      height: 65,
      child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Theme.of(context).primaryColorLight,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
          ),
          onPressed: () {
            showModalBottomSheet(
                backgroundColor: Theme.of(context).primaryColorDark,
                isScrollControlled: true,
                isDismissible: true,
                shape: const RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.vertical(top: Radius.circular(25.0))),
                context: context,
                builder: (context) {
                  return Padding(
                    padding: EdgeInsets.only(
                        bottom: MediaQuery.of(context).viewInsets.bottom),
                    child: SingleChildScrollView(
                        child: buildSMSBottomSheet(
                            context: context,
                            key: formKey,
                            controller: controller)),
                  );
                });
          },
          child: Row(children: const [
            Icon(
              Icons.sms_outlined,
              size: 30,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 25),
              child: Text("Войти по номеру телефона",
                  style: TextStyle(fontFamily: "Lexend", fontSize: 15)),
            )
          ])),
    ),
  );
}

Widget _authWithEmail({
  required BuildContext context,
  required FormKey formKey,
  required TextEditingController controller,
}) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 20.0),
    child: SizedBox(
      height: 65,
      child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Theme.of(context).primaryColor,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
          ),
          onPressed: () {
            showModalBottomSheet(
                backgroundColor:
                    Theme.of(context).bottomSheetTheme.backgroundColor,
                isScrollControlled: true,
                isDismissible: true,
                shape: const RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.vertical(top: Radius.circular(25.0))),
                context: context,
                builder: (context) {
                  return Padding(
                    padding: EdgeInsets.only(
                        bottom: MediaQuery.of(context).viewInsets.bottom),
                    child: SingleChildScrollView(
                        child: buildEmailBottomSheet(
                      context: context,
                      key: formKey,
                      controller: controller,
                    )),
                  );
                });
          },
          child: Row(children: const [
            Icon(
              Icons.mail_outlined,
              size: 30,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 25),
              child: Text(
                "Войти через Email",
                style: TextStyle(fontFamily: "Lexend", fontSize: 15),
              ),
            )
          ])),
    ),
  );
}

Widget _authWithBiometrics(BuildContext context) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 20.0),
    child: SizedBox(
      height: 65,
      child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Theme.of(context).colorScheme.primary,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
          ),
          onPressed: () async {
            await BlocProvider.of<AuthCubit>(context).authByBiometrics();
          },
          child: Row(children: const [
            Icon(
              Icons.fingerprint_outlined,
              size: 30,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 25),
              child: Text(
                "Войти через биометрию",
                style: TextStyle(fontFamily: "Lexend", fontSize: 15),
              ),
            )
          ])),
    ),
  );
}

// Stack(children: [
//             Padding(
//               padding: const EdgeInsets.only(top: 50),
//               child: Align(
//                 alignment: Alignment.topCenter,
//                 child: Column(
//                   children: [
//                     _logo(),
//                     Padding(
//                       padding: const EdgeInsets.all(20.0),
//                       child: Text(
//                         "E-Market",
//                         style: TextStyle(
//                             fontFamily: "Lexend",
//                             fontSize: 35,
//                             color: Theme.of(context).colorScheme.onPrimary,
//                             fontWeight: FontWeight.w700),
//                       ),
//                     ),
//                     const SizedBox(height: 30),
//                     emailField(context: context, formKey: _formKey, controller: _controller),
//                     const SizedBox(height: 30),
//                     Container(
//                         padding:
//                             const EdgeInsets.only(top: 30, left: 80, right: 80),
//                         child: Center(
//                             child: ElevatedButton(
//                                 style: ElevatedButton.styleFrom(
//                                   shape: RoundedRectangleBorder(
//                                       borderRadius: BorderRadius.circular(20)),
//                                   backgroundColor:
//                                       Theme.of(context).colorScheme.primary,
//                                   minimumSize: const Size.fromHeight(50),
//                                 ),
//                                 onPressed: () async {
//                                   if (_formKey.currentState!.validate()) {
//                                     final remote = RemoteDataSource(
//                                         auth: FirebaseAuth.instance,
//                                         dio: Dio(),
//                                         localDataSource:
//                                             LocalDataSource(GetStorage()));

//                                     await remote.sendEmailLink(
//                                         email: _controller.text);
//                                     await remote.retrieveLinkAndSignIn(
//                                         isFirstStart: false);
//                                   }
//                                 },
//                                 child: const Center(
//                                     child: Text("Подтвердить",
//                                         style: TextStyle(
//                                             fontSize: 18,
//                                             fontWeight: FontWeight.w500,
//                                             fontFamily: "Lexend",
//                                             color: Colors.white))))))
//                   ],
//                 ),
//               ),
//             ),
//           ]),
