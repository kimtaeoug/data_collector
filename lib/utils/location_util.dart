import 'dart:async';
import 'dart:io';

import 'package:data_collector/utils/logger_util.dart';
import 'package:geolocator/geolocator.dart';
import 'package:location/location.dart';

///
/// WantedValue : 위도, 경도, 고도
///
class LocationUtil{
  static final LocationUtil _instance = LocationUtil._();
  LocationUtil._();
  factory LocationUtil() => _instance;

  ///
  /// Geolocator
  ///
  void requestPermission()async{
    await Geolocator.requestPermission();
    if(Platform.isIOS){

    }

    // Geolocator.requestTemporaryFullAccuracy(purposeKey: purposeKey)
  }

  StreamSubscription<Position>? _streamSubscription;
  void startListening()async{
    _streamSubscription = Geolocator.getPositionStream().listen(_listener,  );
    // _streamSubscription = Geolocator.getPositionStream().listen(_listener, onError: _errorListener);
  }
  void _listener(Position position){
    Log.i('CurrentPosition : $position');
  }
  void _errorListener(Error error, StackTrace stackTrace){
    Log.e('Error : $error\nStackTrace : $stackTrace');
  }

  final Location location = Location();
  StreamSubscription<LocationData>? _altitudeSubScription;
  void startListeningAltitude()async{
    _altitudeSubScription = location.onLocationChanged.listen(_altitudeListener);
  }
  void _altitudeListener(LocationData data){
    Log.i('altitude : ${data.altitude}');
  }


}