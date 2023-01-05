String formatWorkoutTime(int seconds, bool pod) {
  return (pod)
      ? "${(seconds / 60).floor()} : ${(seconds % 60).toString().padLeft(2, "0")}"
      : seconds > 60
          ? "${(seconds / 60).floor()} : ${(seconds % 60).toString().padLeft(2, "0")}"
          : seconds.toString();
}
