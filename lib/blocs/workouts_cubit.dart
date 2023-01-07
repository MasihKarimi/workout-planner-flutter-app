import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:flutter/services.dart';
import 'package:workout_planner_app/models/exercise.dart';

import '../models/workout.dart';

class WorkoutsCubit extends Cubit<List<Workout>> {
  WorkoutsCubit() : super([]);
  getWorkouts() async {
    final List<Workout> workouts = [];
    final workoutJson =
        jsonDecode(await rootBundle.loadString("assets/workouts.json"));
    for (var el in (workoutJson as Iterable)) {
      workouts.add(Workout.fromJson(el));
    }
    emit(workouts);
  }

  saveWorkout(Workout workout, int index) {
    Workout newWorkout = Workout(title: workout.title, exercises: []);
    int exIndex = 0;
    int startTime = 0;
    for (var ex in workout.exercises) {
      newWorkout.exercises.add(Exercise(
          title: ex.title,
          prelude: ex.prelude,
          duration: ex.duration,
          startTime: ex.startTime,
          index: ex.index));

      exIndex++;
      startTime += ex.prelude + ex.duration;
    }
    state[index] = newWorkout;
    emit([...state]);
  }
}
