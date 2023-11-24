import 'dart:async';

class TimerUtil {
  int timerTime = 180;
  Timer? timer;
  void Function() setWidgetState;

  TimerUtil({required this.setWidgetState});

  void runTimer() {
    timerTime = 180;

    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (timerTime <= 0) {
        timer.cancel();
      } else {
        setWidgetState();
        timerTime--;
      }
    });
  }

  String getTimerText() {
    int min = timerTime ~/ 60;
    int sec = timerTime % 60;
    return '$min:${sec.toString().padLeft(2, '0')}';
  }

  bool isTimerDone() {
    return timerTime <= 0;
  }

  void cancel() {
    timer!.cancel();
  }
}
