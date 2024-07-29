import 'dart:async';

import 'package:battery_plus/battery_plus.dart';
import 'package:data_collector/utils/logger_util.dart';
import 'package:flutter/cupertino.dart';


///
/// Wanted Value : 배터리 상태, 용량
///
class BatteryUtil {
  static final BatteryUtil _instance = BatteryUtil._();

  BatteryUtil._();

  factory BatteryUtil() => _instance;

  final Battery _battery = Battery();

  final ValueNotifier<BatteryState?> batterValue = ValueNotifier(null);

  StreamSubscription<BatteryState>? _batterSubscription;

  void startListener() {
    _batterSubscription = _battery.onBatteryStateChanged
        .listen(_listener);

    // _batterSubscription = _battery.onBatteryStateChanged
    //     .listen(_listener, onError: _errorListener);
  }

  void _listener(BatteryState state) async {
    batterValue.value = state;
    Log.i('BatterState : ${state.name}');
    Log.i('BatterLevel : ${state.index}');
  }

  void _errorListener(Error error, StackTrace stackTrace) {
    Log.e('Error : $error\nStackTrace : $stackTrace');
  }

  void cancelListener() {
    if (_batterSubscription != null) {
      _batterSubscription?.cancel();
    }
  }
}
