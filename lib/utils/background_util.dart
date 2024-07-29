import 'dart:ui';

import 'package:data_collector/utils/activity_recognition_util.dart';
import 'package:data_collector/utils/battery_util.dart';
import 'package:data_collector/utils/ble_util.dart';
import 'package:data_collector/utils/enviroment_util.dart';
import 'package:data_collector/utils/location_util.dart';
import 'package:data_collector/utils/network_util.dart';
import 'package:data_collector/utils/pedometer_util.dart';
import 'package:data_collector/utils/phone_state_util.dart';
import 'package:data_collector/utils/screen_detector_util.dart';
import 'package:data_collector/utils/sensor_util.dart';
import 'package:data_collector/utils/sound_util.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_background_service/flutter_background_service.dart';
import 'package:phone_state/phone_state.dart';

@pragma('vm:entry-point')
void startBackgroundService() {
  final service = FlutterBackgroundService();
  service.startService();
}

void stopBackgroundService() {
  final service = FlutterBackgroundService();
  service.invoke("stop");
}
Future<void> initializeService() async {
  final service = FlutterBackgroundService();
  await service.configure(
    iosConfiguration: IosConfiguration(
      autoStart: true,
      onForeground: onStart,
      onBackground: onIosBackground,
    ),
    androidConfiguration: AndroidConfiguration(
      autoStart: true,
      onStart: onStart,
      isForegroundMode: false,
      autoStartOnBoot: true,
    ),
  );
}

@pragma('vm:entry-point')
Future<bool> onIosBackground(ServiceInstance service) async {
  WidgetsFlutterBinding.ensureInitialized();
  DartPluginRegistrant.ensureInitialized();
  return true;
}

///
/// 실제 Background에서 작업할 로직이 들어갈 곳
///
@pragma('vm:entry-point')
void onStart(ServiceInstance service) async {
  ActivityRecognitionUtil().startListener();
  BatteryUtil().startListener();
  BLEUtil().startScan();
  EnviromentUtil().startListener();
  LocationUtil().startListening();
  LocationUtil().startListeningAltitude();
  NetworkUtil().startListener();
  PedometerUtil().startListener();
  PhoneStateUtil().startListener();
  ScreenDetectorUtil().startListener();
  SensorUtil().initListening();
  SoundUtil().startModeListener();
  SoundUtil().startVolumeListener();

  // final socket = io.io("your-server-url", <String, dynamic>{
  //   'transports': ['websocket'],
  //   'autoConnect': true,
  // });
  // socket.onConnect((_) {
  //   print('Connected. Socket ID: ${socket.id}');
  //   // Implement your socket logic here
  //   // For example, you can listen for events or send data
  // });
  //
  // socket.onDisconnect((_) {
  //   print('Disconnected');
  // });
  // socket.on("event-name", (data) {
  //   //do something here like pushing a notification
  // });
  // service.on("stop").listen((event) {
  //   service.stopSelf();
  //   print("background process is now stopped");
  // });
  //
  // service.on("start").listen((event) {});
  //
  // Timer.periodic(const Duration(seconds: 1), (timer) {
  //   socket.emit("event-name", "your-message");
  //   print("service is successfully running ${DateTime.now().second}");
  // });
}