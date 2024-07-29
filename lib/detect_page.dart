import 'package:data_collector/utils/activity_recognition_util.dart';
import 'package:data_collector/utils/app_checker_util.dart';
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
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class DetectPage extends StatefulWidget {
  const DetectPage({super.key});

  @override
  State<StatefulWidget> createState() => _DetectPage();
}

class _DetectPage extends State<DetectPage> {
  @override
  void initState() {
    // ActivityRecognitionUtil().startListener();
    // BatteryUtil().startListener();
    // BLEUtil().startScan();
    // EnviromentUtil().startListener();
    // LocationUtil().startListening();
    // NetworkUtil().startListener();
    // PedometerUtil().startListener();
    // PhoneStateUtil().startListener();
    // ScreenDetectorUtil().startListener();
    // SensorUtil().initListening();
    // SoundUtil().startModeListener();
    // SoundUtil().startVolumeListener();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  late final Size size = MediaQuery.of(context).size;
  final ActivityRecognitionUtil _activityRecognitionUtil =
      ActivityRecognitionUtil();
  final AppCheckerUtil appCheckerUtil = AppCheckerUtil();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        width: size.width,
        height: size.height,
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              _detectedUIItem(
                  'Am I boarding?', _activityRecognitionUtil.activity),
              _detectedUIItem(
                  '활동 State', _activityRecognitionUtil.confidenceValue),
              _detectedUIItem('설치 앱', appCheckerUtil.installedList),

            ],
          ),
        ),
      ),
    );
  }

  Widget _detectedUIItem(
    String title,
    ValueListenable<dynamic> valueListenable,
  ) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title),
        ValueListenableBuilder(
            valueListenable: valueListenable,
            builder: (context, value, child) {
              if (value is List) {
                return Column(
                  children:
                      List.generate(value.length, (idx) => Text(value[idx])),
                );
              } else {
                return Text('value : $value');
              }
            })
      ],
    );
  }
}
