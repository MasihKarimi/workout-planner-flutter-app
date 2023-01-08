import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:workout_planner_app/blocs/workout_cubit.dart';
import 'package:workout_planner_app/helpers.dart';
import 'package:workout_planner_app/models/exercise.dart';
import 'package:workout_planner_app/states/workout_states.dart';

import 'models/workout.dart';

class WorkoutInProgressScreen extends StatelessWidget {
  const WorkoutInProgressScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Map<String, dynamic> _getStats(Workout workout, int workoutElapsed) {
      int workoutTotal = workout.getTotalTime();
      Exercise exercise = workout.getCurrentExercise(workoutElapsed);
      int exerciseElapsed = workoutElapsed - exercise.startTime!;
      int exerciseRemaining = exercise.prelude - exerciseElapsed;
      bool isPrelude = exerciseElapsed < exercise.prelude;
      int exerciseTotal = isPrelude ? exercise.prelude : exercise.duration;

      if (!isPrelude) {
        exerciseElapsed -= exercise.prelude;
        exerciseRemaining += exercise.duration;
      }

      return {
        "workoutTotal": workout.title,
        "workoutProgress": workoutElapsed / workoutTotal,
        "workoutElapsed": workoutElapsed,
        "totalExercise": workout.exercises.length,
        "currentExerciseIndex": exercise.index!.toDouble(),
        "workoutRemaining": workoutTotal - workoutElapsed,
        "exerciseRemaining": exerciseRemaining,
        "exerciseProgress": exerciseElapsed / exerciseTotal,
        "isPrelude": isPrelude,
        "currentExercise": exercise.title,
      };
    }

    return BlocConsumer<WorkoutCubit, WorkoutState>(
        builder: (context, state) {
          final stats = _getStats(state.workout!, state.elapsed!);

          return Scaffold(
            appBar: AppBar(
              actions: const [],
              leading: BackButton(
                onPressed: () =>
                    BlocProvider.of<WorkoutCubit>(context).goHome(),
              ),
              title: Text(state.workout!.title.toString()),
            ),
            body: Container(
              child: Padding(
                padding: const EdgeInsets.all(30.0),
                child: Column(
                  children: [
                    LinearProgressIndicator(
                      backgroundColor: Colors.blue[100],
                      minHeight: 10,
                      value: stats["workoutProgress"],
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(formatWorkoutTime(stats["workoutElapsed"], true)),
                        DotsIndicator(
                          dotsCount: stats['totalExercise'],
                          position: stats['currentExerciseIndex'],
                        ),
                        Text(
                            "- ${formatWorkoutTime(stats["workoutRemaining"], true)}")
                      ],
                    ),
                    const SizedBox(
                      height: 60,
                    ),
                    Text(
                      stats['isPrelude'] ? "Get Ready For:" : "Start",
                      style: const TextStyle(
                          color: Colors.red,
                          fontSize: 22,
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 10,),
                   
                    Text(
                      "${stats['currentExercise']}",
                      style: const TextStyle(
                          color: Colors.black,
                          fontSize: 22,
                          fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    InkWell(
                      onTap: () {
                        if (state is WorkoutInProgress) {
                          BlocProvider.of<WorkoutCubit>(context).pauseWorkout();
                        } else if (state is PausedWorkout) {
                          BlocProvider.of<WorkoutCubit>(context)
                              .resumeWorkout();
                        }
                      },
                      child: Stack(
                        alignment: const Alignment(0, 0),
                        children: [
                          Center(
                            child: SizedBox(
                                height: 220,
                                width: 220,
                                child: CircularProgressIndicator(
                                  valueColor: AlwaysStoppedAnimation<Color>(
                                      stats['isPrelude']
                                          ? Colors.red
                                          : Colors.blue),
                                  strokeWidth: 25,
                                  value: stats['exerciseProgress'],
                                )),
                          ),
                          Center(
                            child: SizedBox(
                                height: 300,
                                width: 300,
                                child: Padding(
                                  padding: const EdgeInsets.only(bottom: 20),
                                  child: Image.asset("assets/stopwatch.png"),
                                )),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          );
        },
        listener: (context, state) {});
  }
}
