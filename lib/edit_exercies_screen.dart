import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:numberpicker/numberpicker.dart';
import 'package:workout_planner_app/blocs/workouts_cubit.dart';
import 'package:workout_planner_app/helpers.dart';
import 'package:workout_planner_app/models/workout.dart';

class EditExerciseScreen extends StatefulWidget {
  final Workout? workout;
  final int index;
  final int? exIndex;
  const EditExerciseScreen(
      {super.key, this.workout, required this.index, this.exIndex});

  @override
  State<EditExerciseScreen> createState() => _EditExerciseScreenState();
}

class _EditExerciseScreenState extends State<EditExerciseScreen> {
  TextEditingController? _title;

  @override
  void initState() {
    _title = TextEditingController(
        text: widget.workout!.exercises[widget.exIndex!].title);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
                child: InkWell(
              onLongPress: (() {
                showDialog(
                    context: context,
                    builder: (_) {
                      final controller = TextEditingController(
                        text: widget.workout!.exercises[widget.exIndex!].prelude
                            .toString(),
                      );
                      return AlertDialog(
                        content: TextField(
                          controller: controller,
                          decoration: const InputDecoration(
                              labelText: "Prelude (Seconds)"),
                          keyboardType: TextInputType.number,
                          inputFormatters: <TextInputFormatter>[
                            FilteringTextInputFormatter.digitsOnly,
                          ],
                        ),
                        actions: [
                          TextButton(
                              onPressed: () {
                                if (controller.text.isNotEmpty) {
                                  Navigator.pop(context);
                                  setState(() {
                                    widget.workout!.exercises[widget.exIndex!] =
                                        widget
                                            .workout!.exercises[widget.exIndex!]
                                            .copyWith(
                                                prelude:
                                                    int.parse(controller.text));

                                    BlocProvider.of<WorkoutsCubit>(context)
                                        .saveWorkout(
                                            widget.workout!, widget.index);
                                  });
                                }
                              },
                              child: const Text("Save"))
                        ],
                      );
                    });
              }),
              child: NumberPicker(
                  maxValue: 2000,
                  minValue: 0,
                  itemHeight: 30,
                  value: widget.workout!.exercises[widget.exIndex!].prelude,
                  textMapper: (startVal) =>
                      formatWorkoutTime(int.parse(startVal), false),
                  onChanged: (value) => setState(() {
                        widget.workout!.exercises[widget.exIndex!] = widget
                            .workout!.exercises[widget.exIndex!]
                            .copyWith(prelude: value);

                        BlocProvider.of<WorkoutsCubit>(context)
                            .saveWorkout(widget.workout!, widget.index);
                      })),
            )),
            Expanded(
              flex: 3,
                child: TextField(
                    controller: _title,
                    textAlign: TextAlign.center,
                    onChanged: (value) => setState(() {
                          widget.workout!.exercises[widget.exIndex!] = widget
                              .workout!.exercises[widget.exIndex!]
                              .copyWith(title: value);

                          BlocProvider.of<WorkoutsCubit>(context)
                              .saveWorkout(widget.workout!, widget.index);
                        }))),
Expanded(
                child: InkWell(
              onLongPress: (() {
                showDialog(
                    context: context,
                    builder: (_) {
                      final controller = TextEditingController(
                        text: widget.workout!.exercises[widget.exIndex!].duration
                            .toString(),
                      );
                      return AlertDialog(
                        content: TextField(
                          controller: controller,
                          decoration: const InputDecoration(
                              labelText: "Duration (Seconds)"),
                          keyboardType: TextInputType.number,
                          inputFormatters: <TextInputFormatter>[
                            FilteringTextInputFormatter.digitsOnly,
                          ],
                        ),
                        actions: [
                          TextButton(
                              onPressed: () {
                                if (controller.text.isNotEmpty) {
                                  Navigator.pop(context);
                                  setState(() {
                                    widget.workout!.exercises[widget.exIndex!] =
                                        widget
                                            .workout!.exercises[widget.exIndex!]
                                            .copyWith(
                                                duration:
                                                    int.parse(controller.text));

                                    BlocProvider.of<WorkoutsCubit>(context)
                                        .saveWorkout(
                                            widget.workout!, widget.index);
                                  });
                                }
                              },
                              child: const Text("Save"))
                        ],
                      );
                    });
              }),
              child: NumberPicker(
                  maxValue: 2000,
                  minValue: 0,
                  itemHeight: 30,
                  value: widget.workout!.exercises[widget.exIndex!].duration,
                  textMapper: (startVal) =>
                      formatWorkoutTime(int.parse(startVal), false),
                  onChanged: (value) => setState(() {
                        widget.workout!.exercises[widget.exIndex!] = widget
                            .workout!.exercises[widget.exIndex!]
                            .copyWith(duration: value);

                        BlocProvider.of<WorkoutsCubit>(context)
                            .saveWorkout(widget.workout!, widget.index);
                      })),
            )),




          ],
        )
      ],
    );
  }
}
