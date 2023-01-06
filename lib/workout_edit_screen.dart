import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:workout_planner_app/blocs/workout_cubit.dart';
import 'package:workout_planner_app/helpers.dart';
import 'package:workout_planner_app/models/exercise.dart';
import 'package:workout_planner_app/states/workout_states.dart';

class WorkoutEditScreen extends StatefulWidget {
  const WorkoutEditScreen({super.key});

  @override
  State<WorkoutEditScreen> createState() => _WorkoutEditScreenState();
}

class _WorkoutEditScreenState extends State<WorkoutEditScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              BlocProvider.of<WorkoutCubit>(context).goHome();
            },
          ),
          title: const Text("Edit Workout"),
        ),
        body: BlocBuilder<WorkoutCubit, WorkoutState>(
          builder: (context, state) {
            WorkoutEditing we = state as WorkoutEditing;
            return ListView.builder(
              itemCount: we.workout!.exercises.length,
              itemBuilder: (context, index) {
                Exercise exercise = we.workout!.exercises[index];
                return ListTile(
                  leading: Text(formatWorkoutTime(exercise.prelude, true)),
                  title: Text(exercise.title),
                  trailing: Text(formatWorkoutTime(exercise.duration, true)),
                  onTap: () => BlocProvider.of<WorkoutCubit>(context).editExercise(index),
                );
              },
            );
          },
        ));
  }
}
