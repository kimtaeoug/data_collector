import 'dart:async';

import 'package:data_collector/utils/logger_util.dart';
import 'package:phone_state/phone_state.dart';

///
/// Wanted Value : Call log(유형, 전화번호, 시작 시간, 종료 시간)
///
class PhoneStateUtil{
  static final PhoneStateUtil _instance = PhoneStateUtil._();
  PhoneStateUtil._();
  factory PhoneStateUtil() => _instance;

  StreamSubscription<PhoneState>? _phoneSubscription;
  void startListener(){
    _phoneSubscription = PhoneState.stream.listen(_listener,  );

    // _phoneSubscription = PhoneState.stream.listen(_listener, onError: _errorListener);
  }
  void _listener(PhoneState event){
    Log.i('CallState : ${event.status}');
    Log.i('number : ${event.number}');
  }
  void _errorListener(Error error, StackTrace stackTrace){
    Log.e('Error : $error\nStackTrace : $stackTrace');
  }
  void cancelListener(){
    if(_phoneSubscription != null){
      _phoneSubscription?.cancel();
    }
  }
}