import 'package:equatable/equatable.dart';
import 'package:workout_planner_app/models/workout.dart';

abstract class WorkoutState extends Equatable {
  final Workout? workout;
  final int? elapsed;
  const WorkoutState(this.workout, this.elapsed);
}

class WorkoutInProgress extends WorkoutState {
  const WorkoutInProgress(Workout? workout, int? elapsed)
      : super(workout, elapsed);

  @override
  List<Object?> get props => [workout, elapsed];
}

class WorkoutInitial extends WorkoutState {
  const WorkoutInitial() : super(null, 0);
  @override
  List<Object?> get props => [];
}

class WorkoutEditing extends WorkoutState {
  final int? index;
  final int? exIndex;
  const WorkoutEditing(Workout? workout, this.index, this.exIndex)
      : super(workout, 0);

  @override
  List<Object?> get props => [workout, index, exIndex];
}

class PausedWorkout extends WorkoutState {
  const PausedWorkout(Workout? workout, int? elapsed) : super(workout, elapsed);

  @override
  // TODO: implement props
  List<Object?> get props => [workout, elapsed];
}
