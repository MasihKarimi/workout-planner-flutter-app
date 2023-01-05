import 'dart:async';

import 'package:flutter/material.dart';

import 'package:rive/rive.dart';
import 'package:workout_planner_app/home_screen.dart';
import 'package:workout_planner_app/main.dart';

class LoadingScreen extends StatefulWidget {
  static const routeName = '/loading-screen';
  const LoadingScreen({Key? key}) : super(key: key);

  @override
  State<LoadingScreen> createState() => _LoadingScreen();
}

class _LoadingScreen extends State<LoadingScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    startTime();
  }

  // 10 sec time for the welcome screen then the app will be redirected to the signIn screen
  startTime() async {
    var duration = const Duration(seconds: 7);
    return Timer(duration, route);
  }

// redirecting to the ScanMenuScreen for Now
  route() {
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => const MyHomePage()));
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return const SafeArea(
      child: Scaffold(
        body: SizedBox(
          height: double.infinity,
          width: double.infinity,
          child: Center(
            child: RiveAnimation.asset(
              'assets/loading2.riv',
              fit: BoxFit.cover,
            ),
          ),
        ),
      ),
    );
  }
}
