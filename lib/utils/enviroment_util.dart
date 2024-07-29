import 'dart:async';

import 'package:data_collector/utils/logger_util.dart';
import 'package:environment_sensors/environment_sensors.dart';
import 'package:flutter/cupertino.dart';

///
/// WantedValue : 기압
///
class EnviromentUtil {
  static final EnviromentUtil _instance = EnviromentUtil._();

  EnviromentUtil._();

  factory EnviromentUtil() => _instance;

  final EnvironmentSensors _sensors = EnvironmentSensors();

  final ValueNotifier<bool> _tempAvailable = ValueNotifier(false);
  final ValueNotifier<bool> _humidityAvailable = ValueNotifier(false);
  final ValueNotifier<bool> _lightAvailable = ValueNotifier(false);
  final ValueNotifier<bool> _pressureAvailable = ValueNotifier(false);

  void checkEnviromentAvailable() async {
    _tempAvailable.value =
        await _sensors.getSensorAvailable(SensorType.AmbientTemperature);
    _humidityAvailable.value =
        await _sensors.getSensorAvailable(SensorType.Humidity);
    _lightAvailable.value = await _sensors.getSensorAvailable(SensorType.Light);
    _pressureAvailable.value =
        await _sensors.getSensorAvailable(SensorType.Pressure);
    Log.i(
        'Available Enviroment :\nAmbientTemperature : ${_tempAvailable.value}\nHumidity : ${_humidityAvailable.value}\nLight : ${_lightAvailable.value}\nPressure : ${_pressureAvailable.value}');
  }

  StreamSubscription<double>? _temper;
  StreamSubscription<double>? _humi;
  StreamSubscription<double>? _light;
  StreamSubscription<double>? _pressure;

  void startListener() {
    _temper = _sensors.temperature
        .listen(_temperListener);
    _humi =
        _sensors.humidity.listen(_humiListener, );
    _light =
        _sensors.light.listen(_lightListener,  );
    _pressure = _sensors.pressure
        .listen(_pressureListener,  );
    // _temper = _sensors.temperature
    //     .listen(_temperListener, onError: _temperErrorListener);
    // _humi =
    //     _sensors.humidity.listen(_humiListener, onError: _humiErrorListener);
    // _light =
    //     _sensors.light.listen(_lightListener, onError: _lightErrorListener);
    // _pressure = _sensors.pressure
    //     .listen(_pressureListener, onError: _pressureErrorListener);
  }

  void _temperListener(double event) {
    Log.i('nAmbientTemperature : $event');
  }

  void _temperErrorListener(Error error, StackTrace stackTrace) {
    Log.e('Error : $error\nStackTrace : $stackTrace');
  }

  void _humiListener(double event) {
    Log.i('Humidity : $event');
  }

  void _humiErrorListener(Error error, StackTrace stackTrace) {
    Log.e('Error : $error\nStackTrace : $stackTrace');
  }

  void _lightListener(double event) {
    Log.i('Light : $event');
  }

  void _lightErrorListener(Error error, StackTrace stackTrace) {
    Log.e('Error : $error\nStackTrace : $stackTrace');
  }

  void _pressureListener(double event) {
    Log.i('Pressure : $event');
  }

  void _pressureErrorListener(Error error, StackTrace stackTrace) {
    Log.e('Error : $error\nStackTrace : $stackTrace');
  }

  void cancelListener() {
    if (_temper != null) {
      _temper?.cancel();
    }
    if (_humi != null) {
      _humi?.cancel();
    }
    if (_light != null) {
      _light?.cancel();
    }
    if (_pressure != null) {
      _pressure?.cancel();
    }
  }
}
