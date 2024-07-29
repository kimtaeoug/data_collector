import 'dart:async';

import 'package:data_collector/utils/logger_util.dart';
import 'package:network_info_plus/network_info_plus.dart';
import 'package:wifi_iot/wifi_iot.dart';

///
/// Wanted Value : ssid, bssid, 주파수, 신호 강도
///
class NetworkUtil {
  static final NetworkUtil _instance = NetworkUtil._();

  NetworkUtil._();

  factory NetworkUtil() => _instance;

  final NetworkInfo _info = NetworkInfo();
  Duration _duration = const Duration(minutes: 5);
  Timer? _timer;

  void startListener() {
    try {
      _timer = Timer.periodic(_duration, _listener);
    } catch (e, s) {
      Log.e('Error : $e\nStackTrace : $s');
    }
  }

  void _listener(Timer timer) async {
    try {
      String? name = await _info.getWifiName();
      String? bssid = await _info.getWifiBSSID();
    } catch (e, s) {
      Log.e('Error : $e\nStackTrace : $s');
    }
  }

  void cancelListener() {
    if (_timer != null) {
      _timer?.cancel();
      _timer = null;
    }
  }

  ///
  /// WPA : 무선 데이터 보호 방식 와이파이 암호화, WEP : 무선급보안 방식 와이파이 암호화
  ///
  final NetworkSecurity _networkSecurity = NetworkSecurity.WPA;
  final WiFiForIoTPlugin _plugin = WiFiForIoTPlugin();
  Timer? _iotTimer;

  void startIOTListener() {
    try {
      _iotTimer = Timer.periodic(_duration, _iotListener);
    } catch (e, s) {
      Log.e('Error : $e\nStackTrace : $s');
    }
  }

  void _iotListener(Timer timer) async {
    String? ssid = await WiFiForIoTPlugin.getSSID();
    String? bssid = await WiFiForIoTPlugin.getBSSID();
    int? signalStrength = await WiFiForIoTPlugin.getCurrentSignalStrength();
    int? frequency = await WiFiForIoTPlugin.getFrequency();
    Log.i(
        'ssid : $ssid\nbssid : $bssid\nsignalStrength : $signalStrength\nfrequency : $frequency');
  }

  void cancelIOTListener() {
    if (_iotTimer != null) {
      _iotTimer?.cancel();
      _iotTimer = null;
    }
  }
}
