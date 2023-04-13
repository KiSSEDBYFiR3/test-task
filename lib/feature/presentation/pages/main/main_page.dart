import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:scaffold_gradient_background/scaffold_gradient_background.dart';
import 'package:test_task/core/common/list_view_provider.dart';
import 'package:test_task/core/common/theme_provider.dart';
import 'package:test_task/feature/presentation/cubits/main_cubit/main_cubit.dart';
import 'package:test_task/feature/presentation/cubits/main_cubit/main_cubit_states.dart';
import 'package:test_task/feature/presentation/widgets/build_grid_view.dart';
import 'package:test_task/feature/presentation/widgets/build_list_view.dart';
import 'package:test_task/feature/presentation/widgets/snackbar.dart';

@RoutePage()
class MainPage extends ConsumerStatefulWidget {
  const MainPage({super.key});

  @override
  MainPageState createState() => MainPageState();
}

class MainPageState extends ConsumerState<MainPage>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller =
      AnimationController(vsync: this, duration: const Duration(seconds: 1));

  @override
  void initState() {
    ref.read(listViewProvider);
    ref.read(themeModeProvider);
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isListView = ref.watch(listViewProvider);
    final theme = ref.watch(themeModeProvider);
    return ScaffoldGradientBackground(
        gradient: LinearGradient(colors: [
          Theme.of(context).colorScheme.primary,
          Theme.of(context).colorScheme.background,
        ], begin: Alignment.bottomRight, end: Alignment.topLeft),
        appBar: PreferredSize(
            preferredSize: const Size.fromHeight(45),
            child: AppBar(
              backgroundColor: const Color.fromARGB(0, 0, 0, 0),
              elevation: 0,
              title: Row(
                children: [
                  IconButton(
                      onPressed: () {
                        ref.read(themeModeProvider.notifier).state =
                            theme == ThemeMode.light
                                ? ThemeMode.dark
                                : ThemeMode.light;
                      },
                      icon: Icon(theme == ThemeMode.dark
                          ? Icons.light_mode_outlined
                          : Icons.dark_mode_outlined)),
                  Expanded(
                    child: Align(
                      alignment: Alignment.topRight,
                      child: IconButton(
                          icon: AnimatedIcon(
                              icon: AnimatedIcons.list_view,
                              progress: _controller),
                          onPressed: () {
                            if (isListView == true) {
                              _controller.forward();
                              ref.read(listViewProvider.notifier).state = false;
                            } else {
                              _controller.reverse();
                              ref.read(listViewProvider.notifier).state = true;
                            }
                          }),
                    ),
                  ),
                ],
              ),
            )),
        body: BlocBuilder<MainCubit, MainCubitState>(
          builder: (context, state) {
            if (state is InitialState) {
              BlocProvider.of<MainCubit>(context).getProducts();
            }
            if (state is MainCubitLoadingDataState) {
              return Center(
                child: SizedBox(
                  height: 50,
                  width: 50,
                  child: CircularProgressIndicator(
                      color: Theme.of(context).primaryColorDark),
                ),
              );
            }
            if (state is MainCubitLoadedState) {
              return Center(
                child: isListView
                    ? Hero(
                        tag: "TileTag",
                        child: buildListView(context, state.products))
                    : Hero(
                        tag: "TileTag",
                        child: buildGridView(context, state.products)),
              );
            }
            if (state is MainCubitErrorState) {
              return showErrorSnackBar(context, state.message.toString());
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
        ));
  }
}
