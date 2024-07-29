import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/cupertino.dart';

class DeviceInfoUtil{
  static final DeviceInfoUtil _instance = DeviceInfoUtil._();
  DeviceInfoUtil._();
  factory DeviceInfoUtil() => _instance;

  final DeviceInfoPlugin _info = DeviceInfoPlugin();

  final ValueNotifier<AndroidDeviceInfo?> _andInfo = ValueNotifier(null);
  final ValueNotifier<IosDeviceInfo?> _iosInfo = ValueNotifier(null);
  final ValueNotifier<BaseDeviceInfo?> _deviceInfo = ValueNotifier(null);

  AndroidDeviceInfo? get android => _andInfo.value;
  IosDeviceInfo? get ios => _iosInfo.value;
  BaseDeviceInfo? get device => _deviceInfo.value;


  void initInfo()async{
    if(Platform.isAndroid){
      AndroidDeviceInfo andInfo = await _info.androidInfo;
      _andInfo.value = andInfo;
    }else{
      IosDeviceInfo iosInfo = await _info.iosInfo;
      _iosInfo.value = iosInfo;
    }
    BaseDeviceInfo deviceInfo = await _info.deviceInfo;
    _deviceInfo.value = deviceInfo;
  }

}