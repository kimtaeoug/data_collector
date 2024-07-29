import 'dart:async';

import 'package:data_collector/utils/logger_util.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';

///
/// Wanted Value : Mac 주소, Cod(Class of device), 신호 강도
///
class BLEUtil {
  static final BLEUtil _instance = BLEUtil._();

  BLEUtil._();

  factory BLEUtil() => _instance;

  StreamSubscription<List<ScanResult>>? _scanSubscription;

  void startScan() async {
    await FlutterBluePlus.startScan().then((_) {
      _scanSubscription = FlutterBluePlus.onScanResults
          .listen(_listener);
    });
    // await FlutterBluePlus.startScan().then((_) {
    //   _scanSubscription = FlutterBluePlus.onScanResults
    //       .listen(_listener, onError: _errorListener);
    // });
  }

  void _listener(List<ScanResult> scanList) {
    for (ScanResult element in scanList) {
      Log.i(
          'MAC 주소 : ${element.device.id}\nDevice : ${element.device.name}\nSignal Strength : ${element.device.prevBondState?.name}');
    }
  }

  void _errorListener(Error error, StackTrace stackTrace) {
    Log.e('Error : $error\nStackTrace : $stackTrace');
  }

  void cancelScan() async {
    await FlutterBluePlus.stopScan();
    if (_scanSubscription != null) {
      _scanSubscription?.cancel();
    }
  }
}
