import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rive/rive.dart';
import 'package:workout_planner_app/blocs/workouts_cubit.dart';
import 'package:workout_planner_app/home_screen.dart';
import 'package:workout_planner_app/loading_screen.dart';
import 'package:workout_planner_app/models/workout.dart';

void main() {
  runApp(const MyApp());
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
        home: BlocProvider<WorkoutsCubit>(create: (BuildContext context) {
          WorkoutsCubit workCubit = WorkoutsCubit();
          if (workCubit.state.isEmpty) {
            workCubit.getWorkouts();
          }
          return workCubit;
        }, child: BlocBuilder<WorkoutsCubit, List<Workout>>(
          builder: (context, state) {
            return const MyHomePage();
          },
        )));
  }
}

