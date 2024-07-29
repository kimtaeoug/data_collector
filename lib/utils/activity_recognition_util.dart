import 'dart:async';

import 'package:data_collector/utils/logger_util.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_activity_recognition/flutter_activity_recognition.dart';


///
/// Wanted Value : 활동 상태, 활동 시간
///
class ActivityRecognitionUtil{
  static final ActivityRecognitionUtil _instance = ActivityRecognitionUtil._();
  ActivityRecognitionUtil._();
  factory ActivityRecognitionUtil() => _instance;

  final FlutterActivityRecognition _recognition = FlutterActivityRecognition.instance;

  ///
  /// Check Permission
  ///
  void checkPermission()async{
    await _recognition.checkPermission().then((check)async{
      if(check != PermissionRequestResult.GRANTED){
       await _recognition.requestPermission();
      }
    });
  }

  final ValueNotifier<String> activity = ValueNotifier('');
  final ValueNotifier<String> confidenceValue = ValueNotifier('');

  StreamSubscription<Activity>? _activitySubscription;
  void startListener(){
    _activitySubscription = _recognition.activityStream.listen(_listener);

    // _activitySubscription = _recognition.activityStream.listen(_listener, onError: _errorListener);
  }
  void _listener(Activity event){
    switch(event.type){
      case ActivityType.IN_VEHICLE:
        activity.value  = 'Activity Type : IN_VEHICLE';
        Log.i('Activity Type : IN_VEHICLE');
        break;
      case ActivityType.ON_BICYCLE:
        activity.value  = 'Activity Type : IN_VEHICLE';
        Log.i('Activity Type : ON_BICYCLE');
        break;
      case ActivityType.RUNNING:
        activity.value  = 'Activity Type : IN_VEHICLE';
        Log.i('Activity Type : RUNNING');
        break;
      case ActivityType.STILL:
        activity.value  = 'Activity Type : IN_VEHICLE';
        Log.i('Activity Type : STILL(NOT MOVING)');
        break;
      case ActivityType.WALKING:
        activity.value  = 'Activity Type : IN_VEHICLE';
        Log.i('Activity Type : WALKING');
        break;
      case ActivityType.UNKNOWN:
        activity.value  = 'Activity Type : IN_VEHICLE';
        Log.i('Activity Type : UNKNOWN');
        break;
      default:
        activity.value  = 'Activity Type : IN_VEHICLE';
        Log.i('Activity Type : UNKNOWN');
        break;
    }
    _confidence(event.confidence);
  }
  void _confidence(ActivityConfidence confidence){
    switch(confidence){
      case ActivityConfidence.HIGH:
        confidenceValue.value = 'Current Confidence : HIGH';
        Log.i('Current Confidence : HIGH');
      case ActivityConfidence.MEDIUM:
        confidenceValue.value = 'Current Confidence : MEDIUM';
        Log.i('Current Confidence : MEDIUM');
      case ActivityConfidence.LOW:
        confidenceValue.value = 'Current Confidence : LOW';
        Log.i('Current Confidence : LOW');
    }
  }

  void _errorListener(Error error){
    Log.e('Error : $error');
  }

  void cancelListener(){
    if(_activitySubscription != null){
      _activitySubscription?.cancel();
    }
  }
}