import 'package:bloc/bloc.dart';
import 'package:workout_planner_app/states/workout_states.dart';

import '../models/workout.dart';

class WorkoutCubit extends Cubit<WorkoutState> {
  WorkoutCubit() : super(const WorkoutInitial());

  editWorkout(Workout workout, int index) =>
      emit(WorkoutEditing(workout, index));
}
