import 'dart:async';
import 'dart:io';

import 'package:data_collector/utils/device_info_util.dart';
import 'package:data_collector/utils/logger_util.dart';
import 'package:real_volume/real_volume.dart';

///
/// Wanted Value : 벨소리 모드, 볼륨
///
class SoundUtil {
  static final SoundUtil _instance = SoundUtil._();

  SoundUtil._();

  factory SoundUtil() => _instance;

  final DeviceInfoUtil _deviceInfoUtil = DeviceInfoUtil();

  void checkPermission() async {
    if (Platform.isAndroid) {
      if ((_deviceInfoUtil.android!.version.sdkInt >= 6) == true) {
        bool? permission = await RealVolume.isPermissionGranted();
        if (permission == null || permission == false) {
          await RealVolume.openDoNotDisturbSettings();
        }
      }
    }
  }

  StreamSubscription<RingerMode>? _ringerSubscription;

  void startModeListener() {
    _ringerSubscription = RealVolume.onRingerModeChanged
        .listen(_listener,  );
    // _ringerSubscription = RealVolume.onRingerModeChanged
    //     .listen(_listener, onError: _errorListener);
  }

  void _listener(RingerMode mode) {
    Log.i('Current Mode : ${mode.name}');
  }

  void _errorListener(Error error, StackTrace stackTrace) {
    Log.e('Error : $error\nStackTrace : $stackTrace');
  }

  void cancelModeListener() {
    if (_ringerSubscription != null) {
      _ringerSubscription?.cancel();
    }
  }

  StreamSubscription<VolumeObj>? _volumeSubscription;

  void startVolumeListener() {
    _volumeSubscription = RealVolume.onVolumeChanged
        .listen(_volumeListener, );
    // _volumeSubscription = RealVolume.onVolumeChanged
    //     .listen(_volumeListener, onError: _errorVolumeListener);
  }

  void _volumeListener(VolumeObj volume) {
    Log.i('volume : $volume');
  }

  void _errorVolumeListener(Error error, StackTrace stackTrace) {
    Log.e('Error : $error\nStackTrace : $stackTrace');
  }

  void cancelVolumeListener() {
    if (_volumeSubscription != null) {
      _volumeSubscription?.cancel();
    }
  }
}
