import 'dart:developer';

import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:restaurant_app/helper/date_time_helper.dart';
import 'package:restaurant_app/utils/background_service.dart';

class SchedulingProvider extends ChangeNotifier {
  bool _isScheduled = false;
  final int _alarmId = 1;

  bool get isScheduled => _isScheduled;

  Future<bool> scheduledRestaurant(bool value) async {
    _isScheduled = value;
    if (_isScheduled) {
      log('Scheduling Restaurant Activated');
      notifyListeners();
      await AndroidAlarmManager.periodic(
        const Duration(hours: 24),
        _alarmId,
        BackgroundService.callback,
        startAt: DateTimeHelper.format(),
        exact: true,
        wakeup: true,
      );
    } else {
      log('Scheduling Restaurant Canceled');
      notifyListeners();
      await AndroidAlarmManager.cancel(_alarmId);
    }
    return true;
  }

  // New method to cancel the scheduled restaurant notification
  Future<void> cancelScheduledRestaurant() async {
    log('Scheduling Restaurant Canceled');
    notifyListeners();
    await AndroidAlarmManager.cancel(_alarmId);
  }
}
