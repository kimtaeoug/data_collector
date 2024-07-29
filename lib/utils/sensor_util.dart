import 'dart:async';

import 'package:data_collector/utils/logger_util.dart';
import 'package:sensors_plus/sensors_plus.dart';

///
/// Wanted Value : 가속도, 회전, 자기장
///
class SensorUtil {
  static final SensorUtil _instance = SensorUtil._();

  SensorUtil._();

  factory SensorUtil() => _instance;

  final Sensors _sensors = Sensors();

  ///
  ///UserAccelerometerEvent -> 장치의 가속도
  ///AccelerometerEvent -> 중력의 영향을 포함한 가속도(UserAccelerometerEvent와 달리 후처리 없이 센서의 원시 값)
  ///GyroscopeEvent -> 장치의 회전
  ///MagnetometerEvent -> 장치를 둘러싼 자기장
  ///

  final Duration _duration = const Duration(seconds: 1);
  StreamSubscription<UserAccelerometerEvent>? _userAccelerometer;
  StreamSubscription<AccelerometerEvent>? _accelerometer;
  StreamSubscription<GyroscopeEvent>? _gyroscope;
  StreamSubscription<MagnetometerEvent>? _magnet;

  void initListening() {
    _userAccelerometer = _sensors
        .userAccelerometerEventStream(samplingPeriod: _duration)
        .listen(_userAccelerometerListener,
        );
    Log.i('UserAccelerometerListener is start');
    _accelerometer = _sensors
        .accelerometerEventStream(samplingPeriod: _duration)
        .listen(_accelerometerListener, );
    Log.i('AccelerometerListener is start');
    _gyroscope = _sensors
        .gyroscopeEventStream(samplingPeriod: _duration)
        .listen(_gyroscopeListener, );
    Log.i('GyroscopeListener is start');
    _magnet = _sensors
        .magnetometerEventStream(samplingPeriod: _duration)
        .listen(_magnetListener, );
    Log.i('MagnetListener is start');

    // _userAccelerometer = _sensors
    //     .userAccelerometerEventStream(samplingPeriod: _duration)
    //     .listen(_userAccelerometerListener,
    //         onError: _userAccelerometerErrorListener);
    // Log.i('UserAccelerometerListener is start');
    // _accelerometer = _sensors
    //     .accelerometerEventStream(samplingPeriod: _duration)
    //     .listen(_accelerometerListener, onError: _accelerometerErrorListener);
    // Log.i('AccelerometerListener is start');
    // _gyroscope = _sensors
    //     .gyroscopeEventStream(samplingPeriod: _duration)
    //     .listen(_gyroscopeListener, onError: _gyroscopeErrorListener);
    // Log.i('GyroscopeListener is start');
    // _magnet = _sensors
    //     .magnetometerEventStream(samplingPeriod: _duration)
    //     .listen(_magnetListener, onError: _magnetErrorListener);
    // Log.i('MagnetListener is start');
  }

  void _userAccelerometerListener(UserAccelerometerEvent event) {
    Log.i('UserAccelerometerEvent : $event');
  }

  void _userAccelerometerErrorListener(Error error, StackTrace stackTrace) {
    Log.e('Error : $error\nStackTrace : $stackTrace');
  }

  void _accelerometerListener(AccelerometerEvent event) {
    Log.i('AccelerometerListener : $event');
  }

  void _accelerometerErrorListener(Error error, StackTrace stackTrace) {
    Log.e('Error : $error\nStackTrace : $stackTrace');
  }

  void _gyroscopeListener(GyroscopeEvent event) {
    Log.i('GyroscopeListener : $event');
  }

  void _gyroscopeErrorListener(Error error, StackTrace stackTrace) {
    Log.e('Error : $error\nStackTrace : $stackTrace');
  }

  void _magnetListener(MagnetometerEvent event) {
    Log.i('MagnetListener : $event');
  }

  void _magnetErrorListener(Error error, StackTrace stackTrace) {
    Log.e('Error : $error\nStackTrace : $stackTrace');
  }

  void cancelListener() {
    if (_userAccelerometer != null) {
      _userAccelerometer?.cancel();
    }
    if (_accelerometer != null) {
      _accelerometer?.cancel();
    }
    if (_gyroscope != null) {
      _gyroscope?.cancel();
    }
    if (_magnet != null) {
      _magnet?.cancel();
    }
  }
}
