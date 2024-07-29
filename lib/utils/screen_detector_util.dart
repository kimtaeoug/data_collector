import 'dart:async';

import 'package:data_collector/utils/logger_util.dart';
import 'package:flutter/cupertino.dart';
import 'package:is_lock_screen2/is_lock_screen2.dart';
import 'package:keep_screen_on/keep_screen_on.dart';

///
/// Wanted Value : Screen 상태
///
class ScreenDetectorUtil {
  static final ScreenDetectorUtil _instance = ScreenDetectorUtil._();

  ScreenDetectorUtil._();

  factory ScreenDetectorUtil() => _instance;

  final ValueNotifier<ScreenType> _screenType = ValueNotifier(ScreenType.none);
  final Duration _duration = const Duration(seconds: 1);

  Timer? timer;

  void startListener() {
    timer = Timer.periodic(_duration, _callBack);
  }

  void _callBack(Timer timer) async {
    bool? lock = await isLockScreen();
    if (lock == true) {
      _screenType.value = ScreenType.lock;
    }
    bool? keepOn = await KeepScreenOn.isOn;
    if (keepOn == true) {
      _screenType.value = ScreenType.on;
    } else {
      _screenType.value = ScreenType.off;
    }
    Log.i('Current Screen Type : ${_screenType.value.name}');
  }

  void cancelTimer() {
    if (timer != null) {
      timer?.cancel();
      timer = null;
    }
  }
}

enum ScreenType { on, off, lock, none }
