import 'dart:async';
import 'package:mobile_quiz/constants/timerScoreKeeper.dart';
import 'package:scoped_model/scoped_model.dart';

class MyModel extends Model {
  Timer timer;
  int newTime = 0;
  TimerScoreKeeper timerScoreKeeper = TimerScoreKeeper();

  cancelTimer() async {
    try {
      if (timer.isActive != null) {
        timer.cancel();
      }
    } catch (e) {}
  }

  timerCounter({int quizCounter, Function saveFunc}) async {
    timer = Timer.periodic(Duration(seconds: 1), (timer) async {
      if (quizCounter > 0) {
        quizCounter--;
        newTime = quizCounter;
        if (quizCounter == 0) {
          await saveFunc();
        }
        print("new time is $newTime");
        return newTime;
      } else {
        timer.cancel();
      }
    });
  }

  notifyListeners();
}
