import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:workout_planner_app/blocs/workout_cubit.dart';
import 'package:workout_planner_app/blocs/workouts_cubit.dart';
import 'package:workout_planner_app/edit_exercies_screen.dart';
import 'package:workout_planner_app/helpers.dart';
import 'package:workout_planner_app/models/exercise.dart';
import 'package:workout_planner_app/models/workout.dart';
import 'package:workout_planner_app/states/workout_states.dart';

class WorkoutEditScreen extends StatefulWidget {
  const WorkoutEditScreen({super.key});

  @override
  State<WorkoutEditScreen> createState() => _WorkoutEditScreenState();
}

class _WorkoutEditScreenState extends State<WorkoutEditScreen> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => BlocProvider.of<WorkoutCubit>(context).goHome(),
      child: BlocBuilder<WorkoutCubit, WorkoutState>(builder: (context, state) {
        WorkoutEditing we = state as WorkoutEditing;
        return Scaffold(
          appBar: AppBar(
              leading: BackButton(
                onPressed: () {
                  BlocProvider.of<WorkoutCubit>(context).goHome();
                },
              ),
              title: InkWell(
                onTap: (() {
                  showDialog(
                    context: context,
                    builder: (_) {
                      final controller =
                          TextEditingController(text: we.workout!.title!);

                      return AlertDialog(
                        content: TextField(
                          controller: controller,
                          decoration:
                              const InputDecoration(labelText: "Workout Title"),
                        ),
                        actions: [
                          TextButton(
                              onPressed: () {
                                if (controller.text.isNotEmpty) {
                                  Navigator.pop(context);
                                  Workout newTitle = we.workout!
                                      .copyWith(title: controller.text);
                                  BlocProvider.of<WorkoutsCubit>(context)
                                      .saveWorkout(newTitle, we.index!);
                                  BlocProvider.of<WorkoutCubit>(context)
                                      .editWorkout(newTitle, we.index!);
                                }
                              },
                              child: const Text("Rename Title"))
                        ],
                      );
                    },
                  );
                }),
                child: Text(we.workout!.title!),
              ),
              actions: const []),
          body: ListView.builder(
            itemCount: we.workout!.exercises.length,
            itemBuilder: (context, index) {
              Exercise exercise = we.workout!.exercises[index];
              if (we.exIndex == index) {
                return EditExerciseScreen(
                    workout: we.workout, index: index, exIndex: we.exIndex);
              } else {
                return ListTile(
                  leading: Text(formatWorkoutTime(exercise.prelude, true)),
                  title: Text(exercise.title),
                  trailing: Text(formatWorkoutTime(exercise.duration, true)),
                  onTap: () => BlocProvider.of<WorkoutCubit>(context)
                      .editExercise(index),
                );
              }
            },
          ),
        );
      }),
    );
  }
}
