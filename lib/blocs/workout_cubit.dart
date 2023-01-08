import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:wakelock/wakelock.dart';
import 'package:workout_planner_app/states/workout_states.dart';

import '../models/workout.dart';

class WorkoutCubit extends Cubit<WorkoutState> {
  WorkoutCubit() : super(const WorkoutInitial());
  Timer? _timer;

  editWorkout(Workout workout, int index) =>
      emit(WorkoutEditing(workout, index, null));

  editExercise(int? exIndex) => emit(
      WorkoutEditing(state.workout, (state as WorkoutEditing).index, exIndex));

  goHome() => emit(const WorkoutInitial());

  onTick(Timer timer) {
    if (state is WorkoutInProgress) {
      WorkoutInProgress wip = state as WorkoutInProgress;
      if (wip.elapsed! < wip.workout!.getTotalTime()) {
        emit(WorkoutInProgress(wip.workout, wip.elapsed! + 1));
      } else {
        _timer!.cancel();
        Wakelock.disable();
        emit(const WorkoutInitial());
      }
    }
  }

  startWorkout(Workout workout, [int? index]) {
    Wakelock.enable();
    if (index != null) {
    } else {
      emit(WorkoutInProgress(workout, 0));
    }
    _timer = Timer.periodic(const Duration(seconds: 1), onTick);
  }
}
