import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:path_provider/path_provider.dart';
import 'package:workout_planner_app/blocs/workout_cubit.dart';
import 'package:workout_planner_app/blocs/workouts_cubit.dart';
import 'package:workout_planner_app/home_screen.dart';
import 'package:workout_planner_app/states/workout_states.dart';
import 'package:workout_planner_app/workout_edit_screen.dart';
import 'package:workout_planner_app/workout_inprogress_screen.dart';

void main() async {
  //runApp(const MyApp());
  WidgetsFlutterBinding.ensureInitialized();
  final storage = await HydratedStorage.build(
      storageDirectory: await getApplicationDocumentsDirectory());

  HydratedBlocOverrides.runZoned(() => runApp(const MyApp()), storage: storage);
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Workout Planner',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: MultiBlocProvider(
            providers: [
              BlocProvider<WorkoutsCubit>(
                create: (BuildContext context) {
                  WorkoutsCubit workCubit = WorkoutsCubit();
                  if (workCubit.state.isEmpty) {
                    workCubit.getWorkouts();
                  }
                  return workCubit;
                },
              ),
              BlocProvider<WorkoutCubit>(
                  create: (BuildContext context) => WorkoutCubit())
            ],
            child: BlocBuilder<WorkoutCubit, WorkoutState>(
              builder: (context, state) {
                if (state is WorkoutInitial) {
                  return const MyHomePage();
                } else if (state is WorkoutEditing) {
                  return const WorkoutEditScreen();
                }
                return const WorkoutInProgressScreen();
              },
            )));
  }
}
