import 'dart:io';

import 'package:app_usage/app_usage.dart';
import 'package:appcheck/appcheck.dart';
import 'package:data_collector/utils/logger_util.dart';
import 'package:flutter/cupertino.dart';

///
/// Wanted Value : 설치된 앱 종류, 이름, 사용 시간
///
class AppCheckerUtil {
  static final AppCheckerUtil _instance = AppCheckerUtil._();

  AppCheckerUtil._();

  factory AppCheckerUtil() => _instance;

  final AppCheck _appCheck = AppCheck();
  final AppUsage _appUsage = AppUsage();

  final ValueNotifier<List> installedList = ValueNotifier([]);

  void detectApp() async {
    if (Platform.isAndroid) {
      final DateTime now = DateTime.now();
      List<AppUsageInfo> infoList =
          await _appUsage.getAppUsage(now.subtract(Duration(days: 30)), now);
      installedList.value = infoList;
      for (AppUsageInfo element in infoList) {
        Log.i('Installed App : ${element.appName}\n');
        Log.i('Usage : ${element.usage}\n');
        Log.i('StartTime : ${element.startDate}, EndTime : ${element.endDate}');
      }
    } else {
      // ios는 사용 시간 intercept 불가
      List<AppInfo> appList = (await _appCheck.getInstalledApps()) ?? [];
      installedList.value = appList;
      for (AppInfo app in appList) {
        Log.i('Installed App : ${app.appName}');
      }
    }
  }
}
