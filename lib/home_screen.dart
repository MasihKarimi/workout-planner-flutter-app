import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rive/rive.dart';
import 'package:workout_planner_app/blocs/workout_cubit.dart';
import 'package:workout_planner_app/blocs/workouts_cubit.dart';
import 'package:workout_planner_app/helpers.dart';
import 'package:workout_planner_app/models/workout.dart';

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 10,
        title: const Text("Workout Planner "),
        actions: const [
          IconButton(
              onPressed: null,
              icon: Icon(
                Icons.event_available,
                color: Colors.white,
              )),
          IconButton(
              onPressed: null,
              icon: Icon(
                Icons.settings,
                color: Colors.white,
              ))
        ],
      ),
      body: SingleChildScrollView(
        child: BlocBuilder<WorkoutsCubit, List<Workout>>(
          builder: (context, workouts) => ExpansionPanelList.radio(
            children: workouts
                .map((workout) => ExpansionPanelRadio(
                    value: workout,
                    headerBuilder: (context, isExpanded) => ListTile(
                          visualDensity: const VisualDensity(
                              horizontal: 0,
                              vertical: VisualDensity.maximumDensity),
                          leading: IconButton(
                            onPressed: () {
                              print("object");
                              BlocProvider.of<WorkoutCubit>(context)
                                  .editWorkout(workout, workouts.indexOf(workout));
                            },
                            icon: const Icon(Icons.edit),
                          ),
                          title: Text(workout.title!),
                          trailing:
                              Text(formatWorkoutTime(workout.getTotalTime(), true)),
                        ),
                    body: ListView.builder(
                      itemCount: workout.exercises.length,
                      shrinkWrap: true,
                      itemBuilder: (context, index) => ListTile(
                        visualDensity: const VisualDensity(
                            horizontal: 0,
                            vertical: VisualDensity.maximumDensity),
                        leading: Text(formatWorkoutTime(
                            workout.exercises[index].prelude, true)),
                        title: Text(workout.exercises[index].title),
                        trailing: Text("${workout.exercises[index].duration} Sec"),
                      ),
                    )))
                .toList(),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
