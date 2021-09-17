import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/data/latest.dart' as t;
import 'package:timezone/timezone.dart' as tz;
import 'package:todos/models/taskModel.dart';

class NotificationServices {
  NotificationServices._() {
    this.initialize();
  }
  static final instance = NotificationServices._();

  final FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  Future initialize() async {
    final androidInit = AndroidInitializationSettings("ic_launcher");

    final iosInit = IOSInitializationSettings();

    final InitializationSettings initializationSettings =
        InitializationSettings(
      android: androidInit,
      iOS: iosInit,
    );
    await _flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onSelectNotification: onNotificationTapped);
  }

  Future<void> onNotificationTapped(String? payload) async {
    // Navigator.
  }

  Future subscribe(HiveTaskModel data, int id) async {
    final android = AndroidNotificationDetails('id', 'channel', 'des');
    final ios = IOSNotificationDetails();
    final platform = new NotificationDetails(
      android: android,
      iOS: ios,
    );

    t.initializeTimeZones();
    final scheduler = tz.TZDateTime.from(data.dueTime!, tz.local);
    await _flutterLocalNotificationsPlugin.zonedSchedule(
        id, data.title, data.description, scheduler, platform,
        payload: id.toString(),
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.absoluteTime,
        androidAllowWhileIdle: true);
  }

  Future unsubscribe(int id) async {
    await _flutterLocalNotificationsPlugin.cancel(id);
  }
}
