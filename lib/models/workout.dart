import 'package:equatable/equatable.dart';
import 'package:workout_planner_app/models/exercise.dart';

class Workout extends Equatable {
  final String? title;
  final List<Exercise> exercises;
  const Workout({required this.title, required this.exercises});

  factory Workout.fromJson(Map<String, dynamic> json) {
    List<Exercise> exercises = [];
    int index = 0;
    int startTime = 0;

    for (var ex in (json['exercises'] as Iterable)) {
      exercises.add(Exercise.fromJson(ex, index, startTime));
      index++;
      startTime += exercises.last.prelude + exercises.last.duration;
    }
    return Workout(title: json['title'], exercises: exercises);
  }
  Map<String, dynamic> toJson() => {'title': title, 'exercises': exercises};

  // total workout time

  int getTotalTime() {
    int time = exercises.fold(
        0,
        (previousValue, exercise) =>
            previousValue + exercise.duration + exercise.prelude);
    return time;
  }

  @override
  // TODO: implement props
  List<Object?> get props => [title, exercises];

  @override
  bool get stringify => true;
}
