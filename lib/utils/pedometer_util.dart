import 'dart:async';

import 'package:data_collector/utils/logger_util.dart';
import 'package:pedometer/pedometer.dart';

///
/// Wanted Value : 걸음수
///
class PedometerUtil {
  static final PedometerUtil _instance = PedometerUtil._();

  PedometerUtil._();

  factory PedometerUtil() => _instance;

  StreamSubscription<PedestrianStatus>? statusSubscription;
  StreamSubscription<StepCount>? stepSubscription;

  void startListener() {
    statusSubscription = Pedometer.pedestrianStatusStream
        .listen(_statusListener, );
    stepSubscription = Pedometer.stepCountStream
        .listen(_stepListener, );
    // statusSubscription = Pedometer.pedestrianStatusStream
    //     .listen(_statusListener, onError: _statusErrorListener);
    // stepSubscription = Pedometer.stepCountStream
    //     .listen(_stepListener, onError: _stepErrorListener);
  }

  void _statusListener(PedestrianStatus status) {
    Log.i('PedestrianStatus : $status');
  }

  void _statusErrorListener(Error error, StackTrace stackTrace) {
    Log.e('Error : $error\nStackTrace : $stackTrace');
  }

  void _stepListener(StepCount count) {
    Log.i('StepCount : $count');
  }

  void _stepErrorListener(Error error, StackTrace stackTrace) {
    Log.e('Error : $error\nStackTrace : $stackTrace');
  }

  void cancelListener() {
    if (statusSubscription != null) {
      statusSubscription?.cancel();
    }
    if (stepSubscription != null) {
      stepSubscription?.cancel();
    }
  }
}
