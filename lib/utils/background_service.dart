import 'dart:developer';
import 'dart:math' as math;
import 'dart:ui';
import 'dart:isolate';
import 'package:restaurant_app/data/api/restaurant_api_service.dart';
import 'package:restaurant_app/helper/notification_helper.dart';
import 'package:restaurant_app/main.dart';

final ReceivePort port = ReceivePort();

class BackgroundService {
  static BackgroundService? _instance;
  static const String _isolateName = 'isolate';
  static SendPort? _uiSendPort;

  BackgroundService._internal() {
    _instance = this;
  }

  factory BackgroundService() => _instance ?? BackgroundService._internal();

  void initializeIsolate() {
    IsolateNameServer.registerPortWithName(
      port.sendPort,
      _isolateName,
    );
  }

  static Future<void> callback() async {
    log('Alarm fired!');
    final NotificationHelper notificationHelper = NotificationHelper();
    var result = await RestaurantApiService().fetchRestaurantList();
    var randomIndex = math.Random().nextInt(result.length);
    await notificationHelper.showNotification(
        flutterLocalNotificationsPlugin, result[randomIndex]);

    _uiSendPort ??= IsolateNameServer.lookupPortByName(_isolateName);
    _uiSendPort?.send(null);
  }
}
